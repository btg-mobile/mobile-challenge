package com.leonardo.convertcoins

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.core.widget.addTextChangedListener

import com.leonardo.convertcoins.config.Keys
import com.leonardo.convertcoins.config.RetrofitConfig
import com.leonardo.convertcoins.models.Rate
import com.leonardo.convertcoins.models.RealtimeRates
import com.leonardo.convertcoins.models.SupportedCurrencies
import com.leonardo.convertcoins.services.ConvertService
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.*

class MainActivity : AppCompatActivity() {
    private val haveIndex = 0; // INDEX of selected list
    private val wantIndex = 1; // INDEX of selected list

    private val defaultHave = "BRL"
    private val defaultWant = "USD"
    private var toConvertValue = BigDecimal.ZERO

    private val apiConfig = RetrofitConfig()
    private val convertService = ConvertService()
    private val apiKey = Keys().apiKey()


    // map related to the button clicked so when user returns from CurrencyList
    // we can know which information needs to be updated
    private val buttonIdMap = mapOf(
        R.id.button_change_currency_I_have to mapOf(
            "selected" to haveIndex,
            "label" to R.id.currency_I_have,
            "image" to R.id.currency_I_have_image
        ),
        R.id.button_change_currency_I_want to mapOf(
            "selected" to wantIndex,
            "label" to R.id.currency_I_want,
            "image" to R.id.currency_I_want_image
        )
    )

    // start selected list values (currency I have being the first index and currency I want being the second)
    // with negative rates because we do not called the API yet
    private val selected = mutableListOf(Rate(0.0, ""), Rate(0.0, ""))
    private lateinit var realtimeRates: RealtimeRates;
    private lateinit var supportedCurrencies: SupportedCurrencies;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        loading_panel.visibility = View.VISIBLE

        initCurrencyLayer()
        initViewItems()
    }

    private fun initCurrencyLayer() {
        callRealtimeRates()
        callSupportedCurrencies()
    }

    private fun initViewItems() {
        currency_I_have.text = defaultHave
        currency_I_want.text = defaultWant
        input_to_convert.addTextChangedListener { value -> convertCurrency(value.toString()) }
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
                    errorHandler("Erro ao carregar a moeda", false)
            }
        }
    }

    /** navigate to CurrencyList Activity to select a currency
     * @param view is the button clicked (either to change currency I have or currency I want)
     */
    fun goToCurrencyList(view: View) {
        intent = Intent(applicationContext, CurrencyList::class.java)
        intent.putExtra("ID", view.id)
        intent.putExtra("CURRENCIES", supportedCurrencies.currencies)
        val requestCode = resources.getInteger(R.integer.REQUEST_CURRENCY_LIST)
        startActivityForResult(intent, requestCode)
    }

    /** update all activity variables related to the selected coin
     * @param buttonId to differ "I have" and "I want" buttons, and then, update the right variables
     * @param coin as "AUD"
     */
    private fun setCoin(buttonId: Int, coin: String) {
        setCoinOnTemplate(buttonId, coin)
        setCoinOnSharedPreferences(buttonId, coin)
    }

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
            val image: ImageView = findViewById(templateIds["image"]!!)
            val id = resources.getIdentifier("@drawable/${coin.toLowerCase()}", null, packageName)
            if (id > 0) image.setImageResource(id)
            else image.setImageResource(R.drawable.coin_icon)

        }
    }

    private fun setCoinOnSharedPreferences(buttonId: Int, coin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        with (sharedPref.edit()) {
            putString(buttonId.toString(), coin)
            apply()
        }
    }

    private fun initCoin(buttonId: Int, defaultCoin: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        val coin = sharedPref.getString(buttonId.toString(), defaultCoin)!!
        setCoin(buttonId, coin)
    }

    /**
     * function that actually calls convertService, calculate the converted value and show it to the user
     * @param toConvertValue is the value input from user to be converted between currencies
     */
    private fun convertCurrency(toConvertValue: String?) {
        this.toConvertValue = if( toConvertValue.isNullOrBlank()) BigDecimal.ZERO else toConvertValue.toBigDecimal()
        val convertedValue = convertService.convert(selected[haveIndex], selected[wantIndex], this.toConvertValue)

        final_value.text = getTemplateValue(convertedValue)
    }

    private fun getTemplateValue(convertedValue: BigDecimal): String {
        val otherSymbols = DecimalFormatSymbols(Locale.ROOT)
        otherSymbols.decimalSeparator = ','
        otherSymbols.groupingSeparator = '.'
        val df = DecimalFormat("#,###.##", otherSymbols)
        return df.format(convertedValue)
    }

    /**
     * call realtime rates api and return rates related to the USD coin
     */
    private fun callRealtimeRates() {
        val ratesCall = apiConfig.currencyService().getRealtimeRates(apiKey)

        ratesCall.enqueue(object: Callback<RealtimeRates> {
            val errorLabel = "Erro ao fazer a requisição de taxas. Verifique sua internet e abra o aplicativo novamente"
            override fun onResponse(call: Call<RealtimeRates>, response: Response<RealtimeRates>) {
                if (response.body() != null && response.body()?.quotes != null) {
                    realtimeRates = response.body() as RealtimeRates
                    initCoin(R.id.button_change_currency_I_have, defaultHave)
                    initCoin(R.id.button_change_currency_I_want, defaultWant)
                } else
                    errorHandler(errorLabel)
                loading_panel.visibility = View.GONE
            }

            override fun onFailure(call: Call<RealtimeRates>, t: Throwable) {
                errorHandler(errorLabel)
            }
        })

    }

    /**
     * call supported currencies api and return all supported conversion currencies
     */
    private fun callSupportedCurrencies() {
        val currenciesCall = apiConfig.currencyService().getSupportedCurrencies((apiKey))
        currenciesCall.enqueue(object : Callback<SupportedCurrencies> {
            val errorLabel = "Erro ao fazer a requisição de moedas disponíveis"
            override fun onResponse(call: Call<SupportedCurrencies>, response: Response<SupportedCurrencies>) {
                if (response.body() != null && response.body()?.currencies != null)
                    supportedCurrencies = response.body() as SupportedCurrencies
                else
                    errorHandler(errorLabel)
            }

            override fun onFailure(call: Call<SupportedCurrencies>, t: Throwable) {
                errorHandler(errorLabel)
            }
        })
    }

    /** Handle api errors
     * @param label what should be printed on the toast
     */
    private fun errorHandler(label: String, disableButtons: Boolean = true) {
        Toast.makeText(this@MainActivity, label, Toast.LENGTH_SHORT).show()
        if (disableButtons) {
            button_change_currency_I_have.isEnabled = false
            button_change_currency_I_want.isEnabled = false
        }
    }

}