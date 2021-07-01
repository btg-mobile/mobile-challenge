package com.example.currencyconverter.network

import retrofit2.Response
import retrofit2.http.GET

interface Rate {

    @GET("live")
    suspend fun getCurrencyList(): Response<RateResponse>
}