package com.example.currencyapp.network.service

import com.example.currencyapp.network.response.CurrencyRateResponse
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyRate {
    @GET("live?access_key=b3b1a1892bd80e93c51c5ec952c6f6d2")
    suspend fun getCurrencyLive() : Response<CurrencyRateResponse>
}