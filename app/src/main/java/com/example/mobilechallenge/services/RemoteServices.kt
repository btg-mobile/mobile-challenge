package com.example.mobilechallenge.services

import com.example.mobilechallenge.models.CoinsListResponse
import com.example.mobilechallenge.models.CurrenciesResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface RemoteServices {

    @GET("list")
    fun coinsList(
        @Query("access_key") access_key: String
    ): Call<CoinsListResponse>

    @GET("live")
    fun convert(
        @Query("access_key") access_key: String,
        @Query("currencies") currencies: String
    ): Call<CurrenciesResponse>
}