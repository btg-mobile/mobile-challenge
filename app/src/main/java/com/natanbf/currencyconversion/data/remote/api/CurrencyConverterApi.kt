package com.natanbf.currencyconversion.data.remote.api

import com.natanbf.currencyconversion.domain.model.CurrentQuoteResponse
import com.natanbf.currencyconversion.domain.model.ExchangeRatesResponse
import retrofit2.http.GET

interface CurrencyConverterApi {
    @GET("list.json")
    suspend fun getExchangeRates(): ExchangeRatesResponse

    @GET("live.json")
    suspend fun getCurrentQuote(): CurrentQuoteResponse
}
