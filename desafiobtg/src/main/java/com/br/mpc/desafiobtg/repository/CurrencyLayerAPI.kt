package com.br.mpc.desafiobtg.repository

import com.br.mpc.desafiobtg.model.ConvertionResponse
import com.br.mpc.desafiobtg.model.CurrenciesResponse
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerAPI {
    @GET("list")
    suspend fun getCurrencies() : Response<CurrenciesResponse>

    @GET("live")
    suspend fun getConverted() : Response<ConvertionResponse>
}