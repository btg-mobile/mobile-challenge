package com.lucasnav.desafiobtg.modules.currencyConverter.networking

import android.annotation.SuppressLint
import com.lucasnav.desafiobtg.core.network.BaseNetwork
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

object CurrencyNetworking : BaseNetwork() {

    private val API by lazy { getRetrofitBuilder().build().create(CurrencyApi::class.java) }

    @SuppressLint("CheckResult")
    fun getCurrenciesFromApi(
        onSuccess: (currencieResponse: List<Currency>) -> Unit,
        onError: (error: Throwable) -> Unit
    ) {
        API.getCurrenciesFromApi()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ currencyResponse ->
                currencyResponse.let {

                    val currencies = it.currencies?.map {
                        Currency(
                            0,
                            it.key,
                            it.value
                        )
                    }

                    if (currencies != null) {
                        onSuccess(currencies)
                    }
                }
            }, { error ->
                onError(error)
            })
    }

    @SuppressLint("CheckResult")
    fun getQuotesFromApi(
        firsCurrency: String,
        secondCurrency: String,
        onSuccess: (quotesResponse: List<Quote>) -> Unit,
        onError: (error: String) -> Unit
    ) {

        val currencies = if(firsCurrency.isNotEmpty()) "${firsCurrency},${secondCurrency}" else ""

        API.getQuotesFromApi(currencies)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ quotesResponse ->
                quotesResponse.let {

                    if (it.success) {
                        val quotes = it.quotes?.map {
                            Quote(
                                0,
                                it.key,
                                it.value
                            )
                        }

                        if (quotes != null) {
                            onSuccess(quotes)
                        }
                    } else {
                        onError(it.error.code.toString())
                    }
                }
            }, { error ->
                onError(error.message.toString())
            })
    }
}