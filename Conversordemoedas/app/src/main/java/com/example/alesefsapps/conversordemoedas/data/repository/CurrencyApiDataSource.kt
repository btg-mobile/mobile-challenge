package com.example.alesefsapps.conversordemoedas.data.repository

import com.example.alesefsapps.conversordemoedas.data.ApiService.service
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.response.ListCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal

class CurrencyApiDataSource : CurrencyRepository {

    private val apiKey: String = "eab8dae1f01e7d851435fe6c99f756f6"
    private val currencies: MutableList<Currency> = mutableListOf()
    private val quotes: MutableList<Quote> = mutableListOf()
    private val values: MutableList<Values> = mutableListOf()


    override fun getValueLive(valueResultCallback: (result: LiveValueResult) -> Unit) {
        val call = service.getLiveCurrency(apiKey)

        call.enqueue(object : Callback<LiveCurrencyBodyResponse> {
            override fun onResponse(
                call: Call<LiveCurrencyBodyResponse>,
                response: Response<LiveCurrencyBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        response.body()?.quotes?.let {
                            setCurrencyLive(it)
                        }
                        valueResultCallback(LiveValueResult.Success())
                    }
                    else -> {
                        valueResultCallback(LiveValueResult.ApiError(response.code()))
                    }
                }
            }

            override fun onFailure(call: Call<LiveCurrencyBodyResponse>, t: Throwable) {
                valueResultCallback(LiveValueResult.SeverError())
            }

        })
    }

    private fun setCurrencyLive(quote: HashMap<String, BigDecimal>) {
        for (key in quote.keys) {
            quotes.add(Quote(key, quote[key]))
        }
    }


    override fun getCurrency(currenciesResultCallback: (result: CurrencyResult) -> Unit) {
        val call = service.getListCurrency(apiKey)

        call.enqueue(object : Callback<ListCurrencyBodyResponse> {
            override fun onResponse(
                call: Call<ListCurrencyBodyResponse>,
                response: Response<ListCurrencyBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        response.body()?.currencies?.let {
                            setCurrencyList(it)
                        }
                        currenciesResultCallback(CurrencyResult.Success(values))
                    }
                    else -> {
                        currenciesResultCallback(CurrencyResult.ApiError(response.code()))
                    }
                }
            }

            override fun onFailure(call: Call<ListCurrencyBodyResponse>, t: Throwable) {
                currenciesResultCallback(CurrencyResult.SeverError())
            }
        })
    }

    private fun setCurrencyList(currency: HashMap<String, String>) {
        for (key in currency.keys) {
            currencies.add(Currency(key, currency[key]))

            this.quotes.forEach {
                if (it.code.substring(3,6) == key) {
                    values.add(Values(key, currency[key], it.value))
                    values.sortBy { values -> values.name }
                }
            }
        }
    }
}