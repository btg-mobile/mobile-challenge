package com.leonardo.convertcoins

import android.content.Context
import android.content.Intent
import android.graphics.Color
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Layout
import android.text.Spannable
import android.text.SpannableString
import android.text.style.AlignmentSpan
import android.view.MotionEvent
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.core.graphics.BlendModeColorFilterCompat
import androidx.core.graphics.BlendModeCompat
import androidx.core.widget.addTextChangedListener

import com.leonardo.convertcoins.config.Keys
import com.leonardo.convertcoins.config.RetrofitConfig
import com.leonardo.convertcoins.models.Rate
import com.leonardo.convertcoins.models.RealtimeRates
import com.leonardo.convertcoins.models.SupportedCurrencies
import com.leonardo.convertcoins.services.ConvertService
import com.leonardo.convertcoins.services.SQLiteService
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal
import java.util.*

class MainActivity : AppCompatActivity() {
    object INDEX {
        const val HAVE = 0 // INDEX of selected list
        const val WANT = 1 // INDEX of selected list
    }

    object ERROR {
        const val SUPPORTED_CURRENCIES = "SUPPORTED_CURRENCIES"
        const val REALTIME_RATES = "REALTIME_RATES"
        const val LOAD_COIN = "LOAD_COIN"
    }

    object DEFAULT {
        const val I_HAVE = "BRL"
        const val I_WANT = "USD"
    }

    private var toConvertValue = BigDecimal.ZERO

    private val apiConfig = RetrofitConfig()
    private val convertService = ConvertService()
    private val apiKey = Keys().apiKey()


    // map related to the button clicked so when user returns from CurrencyList
    // we can know which information needs to be updated
    private val buttonIdMap = mapOf(
        R.id.button_change_currency_I_have to mapOf(
            "selected" to INDEX.HAVE,
            "label" to R.id.currency_I_have,
            "image" to R.id.currency_I_have_image
        ),
        R.id.button_change_currency_I_want to mapOf(
            "selected" to INDEX.WANT,
            "label" to R.id.currency_I_want,
            "image" to R.id.currency_I_want_image
        )
    )

    // start selected list values (currency I have being the first index and currency I want being the second)
    // with negative rates because we do not called the API yet
    private val selected = mutableListOf(Rate(0.0, ""), Rate(0.0, ""))
    private lateinit var dbService: SQLiteService
    private lateinit var realtimeRates: RealtimeRates
    private lateinit var supportedCurrencies: SupportedCurrencies

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        loading_panel.visibility = View.VISIBLE

        dbService = SQLiteService(applicationContext, MODE_PRIVATE)
        supportedCurrencies = dbService.getSavedSupportedCurrencies()
        realtimeRates = dbService.getSavedRealtimeRates()

        initCoins()
        initCurrencyLayer()
        initViewItems()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val currencyRequestCode = resources.getInteger(R.integer.REQUEST_CURRENCY_LIST)
        if (resultCode == RESULT_OK && requestCode == currencyRequestCode) {
            if (data !== null) {
                val buttonId = data.getIntExtra("ID", 0)
                val coin = data.getStringExtra("CURRENCIES")
                if (buttonId != 0 && coin !== null) {
                    setCoin(buttonId, coin)
                    convertCurrency(toConvertValue.toString())  // call again when currency changes
                }
                else
                    errorHandler("Erro ao carregar a moeda", ERROR.LOAD_COIN)
            }
        }
    }

    /**
     * Init currencyLayer api calling both realtimeRates and supportedCurrencies
     */
    private fun initCurrencyLayer() {
        callRealtimeRates()
        callSupportedCurrencies()
    }

    /**
     * Init view elements and set needed listeners
     */
    private fun initViewItems() {
        // init currencies labels
        currency_I_have.text = DEFAULT.I_HAVE
        currency_I_want.text = DEFAULT.I_WANT

        // add listener so every time user types a new value its automatic converted
        input_to_convert.addTextChangedListener { value -> convertCurrency(value.toString()) }

        // add style on invert_coins_image so it looks like a button when clicked
        invert_coins_image.setOnTouchListener { v, event ->
            val view = v as ImageView
            when (event?.action) {
                MotionEvent.ACTION_DOWN -> {
                    view.drawable.colorFilter =
                            BlendModeColorFilterCompat.createBlendModeColorFilterCompat(Color.parseColor("#FF353C81"), BlendModeCompat.SRC_ATOP)
                    view.invalidate()
                }

                MotionEvent.ACTION_CANCEL,
                MotionEvent.ACTION_UP -> {
                    view.performClick() // accessibility
                    view.drawable.clearColorFilter()
                    view.invalidate()
                }
            }
            true
        }
    }

    /** Navigate to CurrencyList Activity to select a currency
     * @param view is the button clicked (either to change currency I have or currency I want)
     */
    fun goToCurrencyList(view: View) {
        intent = Intent(applicationContext, CurrencyList::class.java)
        intent.putExtra("ID", view.id)
        intent.putExtra("CURRENCIES", supportedCurrencies.currencies)
        val requestCode = resources.getInteger(R.integer.REQUEST_CURRENCY_LIST)
        startActivityForResult(intent, requestCode)
    }

    /**
     * Invert coin I have with coin I want and call convertCurrency again to update and show
     * the converted value properly.
     */
    fun invertCoins(view: View) {
        selected.reverse()
        setCoin(R.id.button_change_currency_I_have, selected[INDEX.HAVE].coin)
        setCoin(R.id.button_change_currency_I_want, selected[INDEX.WANT].coin)
        convertCurrency(toConvertValue.toString())
    }

    /** Update all activity variables related to the selected coin
     * @param buttonId to differ "I have" and "I want" buttons, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoin(buttonId: Int, coin: String) {
        setCoinOnTemplate(buttonId, coin)
        setCoinOnSharedPreferences(buttonId, coin)
    }

    /** Set coin on template updating image, label and state list "selected"
     * @param buttonId to differ "I have" and "I want" buttons, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoinOnTemplate(buttonId: Int, coin: String) {
        val templateIds = buttonIdMap[buttonId]
        if (templateIds != null) {
            // access buttonMap properties to get selected index and
            // view ids (text and image) to properly update the template
            val index = templateIds["selected"]!!
            val label: TextView = findViewById(templateIds["label"]!!)
            val rate = convertService.getCurrentRate(coin, realtimeRates.quotes)

            selected[index] = Rate(rate, coin)
            label.text = coin
            // draw the res image related to the selected currency if it exists,
            // otherwise, draw default coin label
            val image: ImageView = findViewById(templateIds["image"]!!)
            val id = resources.getIdentifier("@drawable/${coin.toLowerCase()}", null, packageName)
            if (id > 0) image.setImageResource(id)
            else image.setImageResource(R.drawable.coin_icon)

        }
    }

    /** Set coin on shared preferences saving only the string representing the selected coin
     * @param buttonId to differ "I have" and "I want" buttons, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoinOnSharedPreferences(buttonId: Int, coin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        with (sharedPref.edit()) {
            putString(buttonId.toString(), coin)
            apply()
        }
    }

    /**
     * Function that wrapper both coins to be initialized and should be called
     * every time realtimeRate variable is updated
     */
    private fun initCoins() {
        initCoin(R.id.button_change_currency_I_have, DEFAULT.I_HAVE)
        initCoin(R.id.button_change_currency_I_want, DEFAULT.I_WANT)
    }
    /** Access shared preferences to get last user selected coin. Used to start the screen
     * When the user do not selected any coin yet
     * @param buttonId to differ "I have" and "I want" buttons, and then, update the right variables
     * @param defaultCoin as "AUD"
     */
    private fun initCoin(buttonId: Int, defaultCoin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        val coin = sharedPref.getString(buttonId.toString(), defaultCoin)!!
        setCoin(buttonId, coin)
    }

    /**
     * Call convertService, calculate the converted value and show it to the user
     * @param toConvertValue is the value input from user to be converted between currencies
     */
    private fun convertCurrency(toConvertValue: String?) {
        this.toConvertValue = if( toConvertValue.isNullOrBlank()) BigDecimal.ZERO else toConvertValue.toBigDecimal()
        val convertedValue = convertService.convert(selected[INDEX.HAVE], selected[INDEX.WANT], this.toConvertValue)
        final_value.text = convertService.getFormattedValue(convertedValue)
    }

    /**
     * Call supported currencies api and return all supported conversion currencies
     */
    private fun callSupportedCurrencies() {
        val currenciesCall = apiConfig.currencyService().getSupportedCurrencies((apiKey))
        currenciesCall.enqueue(object : Callback<SupportedCurrencies> {
            val errorLabel = "Erro ao fazer a requisição de moedas disponíveis."
            override fun onResponse(call: Call<SupportedCurrencies>, response: Response<SupportedCurrencies>) {
                if (response.body() != null && response.body()?.currencies != null) {
                    supportedCurrencies = response.body() as SupportedCurrencies
                    dbService.saveCurrencies(supportedCurrencies)
                } else
                    errorHandler(errorLabel, ERROR.SUPPORTED_CURRENCIES)
            }

            override fun onFailure(call: Call<SupportedCurrencies>, t: Throwable) {
                errorHandler(errorLabel, ERROR.SUPPORTED_CURRENCIES)
            }
        })
    }

    /**
     * Call realtime rates api and return rates related to the USD coin
     */
    private fun callRealtimeRates() {
        val ratesCall = apiConfig.currencyService().getRealtimeRates(apiKey)

        ratesCall.enqueue(object: Callback<RealtimeRates> {
            val errorLabel = "Erro ao fazer a requisição de taxas"
            override fun onResponse(call: Call<RealtimeRates>, response: Response<RealtimeRates>) {
                if (response.body() != null && response.body()?.quotes != null) {
                    realtimeRates = response.body() as RealtimeRates
                    dbService.saveQuotes(realtimeRates)
                    initCoins()
                } else
                    errorHandler(errorLabel, ERROR.REALTIME_RATES)
                loading_panel.visibility = View.GONE
            }

            override fun onFailure(call: Call<RealtimeRates>, t: Throwable) {
                errorHandler(errorLabel, ERROR.REALTIME_RATES)
                loading_panel.visibility = View.GONE
            }
        })

    }

    /** Handle api errors
     * @param label what should be printed on the toast
     * @param type that should be one of the object ERROR types
     */
    private fun errorHandler(label: String, type: String) {
        checkShowToast(label, type)
        checkDisableButtons(type)
        checkShowDialog(type)
    }

    /**
     * Check if toast should be shown for the specific error type
     * @param label what should be printed on the toast
     * @param type that should be one of the object ERROR types
     */
    private fun checkShowToast(label: String, type: String) {
        if (type != ERROR.REALTIME_RATES) {
            showToast(label)
        }
    }
    /**
     * Show error toast on screen with a spannable String centralized
     * @param label text to be centrilzed and displayed inside the toast
     */
    private fun showToast(label: String) {
        val text = SpannableString(label)
        text.setSpan(AlignmentSpan.Standard(Layout.Alignment.ALIGN_CENTER),
                0, text.length - 1, Spannable.SPAN_INCLUSIVE_EXCLUSIVE
        )
        Toast.makeText(this@MainActivity, text, Toast.LENGTH_SHORT).show()
    }

    /**
     * Check if buttons should be mark as disable blocking naviagete to currencyList
     * @param type that should be one of the object  ERROR types
     */
    private fun checkDisableButtons(type: String) {
        if (type == ERROR.SUPPORTED_CURRENCIES
                && (!this::supportedCurrencies.isInitialized || supportedCurrencies.currencies.isEmpty())) {
            button_change_currency_I_have.isEnabled = false
            button_change_currency_I_want.isEnabled = false
        }
    }

    /**
     * Check if dialog should be shown based on error type
     * @param type that should be one of the object ERROR types
     */
    private fun checkShowDialog(type: String) {
        if (type == ERROR.REALTIME_RATES
                && !this::realtimeRates.isInitialized || realtimeRates.quotes.isEmpty()) {
            val dialog = AlertDialog.Builder(this@MainActivity)
            dialog.setTitle("Erro ao carregar as cotações")
            dialog.setMessage("Não foi possível carregar as informações referentes as cotações" +
                    " das moedas. Verifique sua interenet e tente novamente")
            dialog.setPositiveButton("Ok") { _, _ -> {} }
            dialog.create()
            dialog.show()
        }
    }
}