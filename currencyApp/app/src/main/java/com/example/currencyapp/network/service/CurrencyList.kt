package com.example.currencyapp.network.service

import com.example.currencyapp.network.response.CurrencyListResponse
import retrofit2.Response
import retrofit2.http.GET


interface CurrencyList {
    @GET("list?access_key=b3b1a1892bd80e93c51c5ec952c6f6d2")
    suspend fun getCurrencyList() : Response<CurrencyListResponse>
}