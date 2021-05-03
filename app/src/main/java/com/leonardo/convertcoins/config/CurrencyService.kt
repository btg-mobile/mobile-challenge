package com.leonardo.convertcoins.config

import com.leonardo.convertcoins.model.RealtimeRates
import com.leonardo.convertcoins.model.SupportedCurrencies
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyService {
    @GET("live")
    fun getRealtimeRates(@Query("access_key") accessKey: String): Call<RealtimeRates>

    @GET("list")
    fun getSupportedCurrencies(@Query("access_key") accessKey: String): Call<SupportedCurrencies>
}