package com.a.coinmaster.api

import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.response.CurrencyResponse
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Query

interface CoinMasterApi {
    @GET(CURRENCY_ENDPOINT)
    fun getCurrency(
        @Query(QUERY_CURRENCIES) coin: String
    ): Single<CurrencyResponse>

    @GET(LIST_ENDPOINT)
    fun getCurrenciesList(
    ): Single<CurrenciesListResponse>

    companion object {
        private const val QUERY_CURRENCIES = "currencies"
        private const val CURRENCY_ENDPOINT = "live"
        private const val LIST_ENDPOINT = "list"
    }
}