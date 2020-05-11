package com.lucasnav.desafiobtg.modules.currencyConverter.networking

import android.annotation.SuppressLint
import com.lucasnav.desafiobtg.core.network.BaseNetwork
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency

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
}