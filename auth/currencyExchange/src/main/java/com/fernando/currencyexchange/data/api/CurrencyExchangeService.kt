package com.fernando.currencyexchange.data.api

import com.fernando.currencyexchange.model.CurrencyExchange
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyExchangeService {

    @GET("live?access_key=48125b5d15ed2d98ad9ac92bd9f98ac8")
    suspend fun getCurrency(): Response<CurrencyExchange>
}