package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import android.util.Log
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.ApiService
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.response.ListCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal

class SelectorViewModel : ViewModel() {

    private val api_key: String = "PUT_YOUR_KEY"

    private val service = ApiService.service
    val viewFlipperLiveData: MutableLiveData<Pair<Int, Int?>> = MutableLiveData()

    val selectorLiveData: MutableLiveData<List<Values>> = MutableLiveData()
    private val currencies: MutableList<Currency> = mutableListOf()
    private val quotes: MutableList<Quote> = mutableListOf()
    private val values: MutableList<Values> = mutableListOf()



    companion object {
        private const val VIEW_FLIPPER_CURRENCY_LIST = 1
        private const val VIEW_FLIPPER_ERROR = 2
    }

    fun getCurrency() {
        val call = service.getListCurrency(api_key)

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
                    }
                    response.code() == 401 -> {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_401)
                    }
                    else -> {
                        viewFlipperLiveData.value =
                            Pair(VIEW_FLIPPER_ERROR, R.string.error_generico)
                    }
                }
            }

            override fun onFailure(call: Call<ListCurrencyBodyResponse>, t: Throwable) {
                viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_500)
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

        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_CURRENCY_LIST, null)
        selectorLiveData.value = values
    }



    fun getValueLive() {
        val call = service.getLiveCurrency(api_key)

        call.enqueue(object : Callback<LiveCurrencyBodyResponse> {
            override fun onFailure(call: Call<LiveCurrencyBodyResponse>, t: Throwable) {
                Log.e("XXXXe", t.message)
            }

            override fun onResponse(
                call: Call<LiveCurrencyBodyResponse>,
                response: Response<LiveCurrencyBodyResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.quotes?.let {
                        setCurrencyLive(it)
                    }
                }
            }
        })
    }

    private fun setCurrencyLive(quote: HashMap<String, BigDecimal>/*, code: MutableSet<String>*/) {
        for (key in quote.keys) {
            quotes.add(Quote(key, quote[key]))
        }

        getCurrency()
    }

}