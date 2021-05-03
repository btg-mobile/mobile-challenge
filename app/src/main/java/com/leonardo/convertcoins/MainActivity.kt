package com.leonardo.convertcoins

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.leonardo.convertcoins.config.Constants
import com.leonardo.convertcoins.config.Keys
import com.leonardo.convertcoins.config.RetrofitConfig
import com.leonardo.convertcoins.model.RealtimeRates
import com.leonardo.convertcoins.model.SupportedCurrencies
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainActivity : AppCompatActivity() {

    private lateinit var realtimeRates: RealtimeRates;
    private lateinit var supportedCurrencies: SupportedCurrencies;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val config = RetrofitConfig()
        val apiKey = Keys().apiKey()

        val ratesCall = config.currencyService().getRealtimeRates(apiKey)
        val currenciesCall = config.currencyService().getSupportedCurrencies((apiKey))

        ratesCall.enqueue(object: Callback<RealtimeRates> {
            val errorLabel = "Erro ao fazer a requisição de taxas"
            override fun onResponse(call: Call<RealtimeRates>, response: Response<RealtimeRates>) {
                if (response.body() != null && response.body()?.quotes != null)
                    realtimeRates = response.body() as RealtimeRates
                else
                    errorHandler(errorLabel)

            }

            override fun onFailure(call: Call<RealtimeRates>, t: Throwable) {
                errorHandler(errorLabel)
            }
        })

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
    fun errorHandler(label: String) {
        Toast.makeText(this@MainActivity, label, Toast.LENGTH_SHORT).show()
    }

    fun goToCurrencyList(view: View) {
        intent = Intent(applicationContext, CurrencyList::class.java)
        intent.putExtra(Constants.INTENT.ID, view.id)
        intent.putExtra(Constants.INTENT.CURRENCIES, supportedCurrencies.currencies)
        startActivityForResult(intent, Constants.FEATURE.LIST_CURRENCY)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK) {
            println("result ok")
            println(data?.getStringExtra(Constants.INTENT.CURRENCIES))
        }
    }
}