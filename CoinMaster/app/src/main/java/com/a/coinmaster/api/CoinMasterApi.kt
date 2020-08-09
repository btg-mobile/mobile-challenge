package com.a.coinmaster.api

import com.a.coinmaster.BuildConfig
import retrofit2.http.GET
import retrofit2.http.Query

interface CoinMasterApi {
    @GET(CURRENCY_ENDPOINT)
    fun getCurrencyByCoin(@Query(QUERY_CURRENCIES) coin: String): Any

    @GET(LIST_ENDPOINT)
    fun getCurrenciesList(): Any

    companion object {
        private const val QUERY_ACCESS_KEY = "?access_key=${BuildConfig.CURRENCYLAYER_ACCESS_KEY}"
        private const val QUERY_CURRENCIES = "currencies"
        private const val CURRENCY_ENDPOINT = "live$QUERY_ACCESS_KEY"
        private const val LIST_ENDPOINT = "list$QUERY_ACCESS_KEY"
    }
}