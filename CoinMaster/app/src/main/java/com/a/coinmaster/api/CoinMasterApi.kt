package com.a.coinmaster.api

import com.a.coinmaster.BuildConfig
import com.a.coinmaster.model.CurrenciesListResponse
import com.a.coinmaster.model.CurrencyResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CoinMasterApi {
    @GET(CURRENCY_ENDPOINT)
    fun getCurrency(@Query(QUERY_CURRENCIES) coin: String): CurrencyResponse

    @GET(LIST_ENDPOINT)
    fun getCurrenciesList(): CurrenciesListResponse

    companion object {
        private const val QUERY_ACCESS_KEY = "?access_key=${BuildConfig.CURRENCYLAYER_ACCESS_KEY}"
        private const val QUERY_CURRENCIES = "currencies"
        private const val CURRENCY_ENDPOINT = "live$QUERY_ACCESS_KEY"
        private const val LIST_ENDPOINT = "list$QUERY_ACCESS_KEY"
    }
}