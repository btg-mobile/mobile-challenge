package io.felipeandrade.data.api

import io.felipeandrade.data.api.response.LiveCurrenciesResponse
import io.felipeandrade.data.api.response.SupportedCurrenciesResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {

    @GET("list")
    fun loadSupportedCurrencies(@Query("access_key") apiKey: String): SupportedCurrenciesResponse

    @GET("live")
    fun loadLiveCurrencies(@Query("access_key") apiKey: String): LiveCurrenciesResponse

}