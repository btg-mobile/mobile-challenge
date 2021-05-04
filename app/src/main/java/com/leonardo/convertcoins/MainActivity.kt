package com.leonardo.convertcoins

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.core.widget.addTextChangedListener
import com.leonardo.convertcoins.config.Constants
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
import java.lang.Exception
import java.util.*

class MainActivity : AppCompatActivity() {
    private val haveIndex = 0; // INDEX of selected list
    private val wantIndex = 1; // INDEX of selected list

    private val defaultHave = "BRL"
    private val defaultWant = "USD"
    private var toConvertValue = 0.0

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
    private lateinit var selected: MutableList<Rate>
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
        val templateIds = buttonIdMap[buttonId]
        if (templateIds != null) {
            // access buttonMap properties to get selected index and
            // view ids (text and image) to properly update the template
            val index = templateIds["selected"]!!
            val label: TextView = findViewById(templateIds["label"]!!)
            val rate = convertService.getCurrentRate(coin, realtimeRates.quotes)

            selected[index] = Rate(rate, coin)
            label.text = coin
//            TODO:
//            val image: ImageView = findViewById(templateIds["image"]!!)
        }
    }

    private fun convertCurrency(toConvertValue: String?) {
        this.toConvertValue = if( toConvertValue.isNullOrBlank()) 0.0 else toConvertValue.toDouble()
        val convertedValue = convertService.convert(selected[haveIndex], selected[wantIndex], this.toConvertValue)
        println(convertedValue)
        final_value.text = convertedValue.toString()
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
                    val haveRate = convertService.getCurrentRate(defaultHave, realtimeRates.quotes)
                    val wantRate = convertService.getCurrentRate(defaultWant, realtimeRates.quotes)
                    selected = mutableListOf(Rate(haveRate, "BRL"), Rate(wantRate, "USD"))
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