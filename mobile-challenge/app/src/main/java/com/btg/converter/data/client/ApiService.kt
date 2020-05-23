package com.btg.converter.data.client

import com.btg.converter.data.entity.ApiCurrencyList
import com.btg.converter.data.entity.ApiCurrentQuotes
import retrofit2.Response
import retrofit2.http.GET

interface ApiService {

    @GET("list")
    suspend fun getCurrencyList(): Response<ApiCurrencyList>

    @GET("live")
    suspend fun getCurrentQuotes(): Response<ApiCurrentQuotes>
}