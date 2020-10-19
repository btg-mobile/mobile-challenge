package com.helano.network.services

import com.helano.network.responses.ListResponse
import com.helano.network.responses.LiveResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {

    @GET("/list")
    suspend fun list(@Query("access_key") apiKey: String): ListResponse

    @GET("/live")
    suspend fun live(@Query("access_key") apiKey: String): LiveResponse
}