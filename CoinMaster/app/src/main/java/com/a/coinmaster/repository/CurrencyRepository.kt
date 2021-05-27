package com.a.coinmaster.repository

import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.response.CurrencyResponse
import io.reactivex.Single

interface CurrencyRepository {
    fun getCurrenciesList(): Single<CurrenciesListResponse>
    fun getCurrency(coin: String): Single<CurrencyResponse>
}