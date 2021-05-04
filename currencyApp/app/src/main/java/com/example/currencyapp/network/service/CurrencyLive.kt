package com.example.currencyapp.network.service

import com.example.currencyapp.network.response.CurrencyLiveResponse
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyLive {
    @GET("live")
    suspend fun getCurrencyLive() : Response<CurrencyLiveResponse>
}