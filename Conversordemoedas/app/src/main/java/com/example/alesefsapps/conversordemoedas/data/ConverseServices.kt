package com.example.alesefsapps.conversordemoedas.data

import com.example.alesefsapps.conversordemoedas.data.response.ListCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface ConverseServices {

//    @GET("list")
    @GET("5e4d37e52d00006f00c0dbca")
    fun getListCurrency(
        @Query("access_key") apiKey: String
    ): Call<ListCurrencyBodyResponse>

    //@GET("live")
    @GET("5e4d38752d00007049c0dbd5")
    fun getLiveCurrency(
        @Query("access_key") apiKey: String
    ): Call<LiveCurrencyBodyResponse>
}
