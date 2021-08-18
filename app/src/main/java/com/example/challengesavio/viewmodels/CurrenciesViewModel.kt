package com.example.challengesavio.viewmodels

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.challengesavio.api.models.CurrenciesOutputs
import com.example.challengesavio.api.models.QuotesOutputs
import com.example.challengesavio.api.repositories.MainRepository
import com.example.challengesavio.utilities.CurrenciesListener
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class CurrenciesViewModel constructor(private val repository: MainRepository)  : ViewModel() {

    var currenciesListener : CurrenciesListener?= null

    fun getAllCurrencies(){

        val request = repository.getAllCurrencies()
        request.enqueue(object : Callback<CurrenciesOutputs?> {

            override fun onResponse(
                call: Call<CurrenciesOutputs?>,
                response: Response<CurrenciesOutputs?>
            ) {
                currenciesListener?.onCurrenciesResult(response.body()!!.currencies!!)
            }

            override fun onFailure(call: Call<CurrenciesOutputs?>, t: Throwable) {

            }
        })

    }

    fun getAllQuotes() {

        val request = repository.getAllQuotes()
        request.enqueue(object : Callback<QuotesOutputs?> {

            override fun onResponse(
                call: Call<QuotesOutputs?>,
                response: Response<QuotesOutputs?>
            ) {
                currenciesListener?.onQuotesResult(response.body()!!.quotes!!)
            }

            override fun onFailure(call: Call<QuotesOutputs?>, t: Throwable) {
//
            }
        })

    }
}