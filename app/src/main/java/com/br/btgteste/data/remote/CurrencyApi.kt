package com.br.btgteste.data.remote

import com.br.btgteste.data.model.CurrencyList
import com.br.btgteste.data.model.CurrencyLive
import retrofit2.http.GET

interface CurrencyApi {

    @GET("list")
    suspend fun getCurrencyList(): CurrencyList

    @GET("live")
    suspend fun getCurrencyLive(): CurrencyLive
}