package com.leonardo.convertcoins

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.leonardo.convertcoins.config.Keys
import com.leonardo.convertcoins.config.RetrofitConfig
import com.leonardo.convertcoins.model.RealtimeRates
import com.leonardo.convertcoins.model.SupportedCurrencies
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainActivity : AppCompatActivity() {

    lateinit var realtimeRates: RealtimeRates;
    lateinit var supportedCurrencies: SupportedCurrencies;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val config = RetrofitConfig()
        val apiKey = Keys().apiKey()
        println(apiKey)

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
                println("Success BITCH")
                println(response.body())
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
}