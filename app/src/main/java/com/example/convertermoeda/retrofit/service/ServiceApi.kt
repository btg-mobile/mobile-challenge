package com.example.convertermoeda.retrofit.service

import com.example.convertermoeda.model.ListMoeda
import com.example.convertermoeda.model.Live
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface ServiceApi {

    @GET("live?access_key")
    fun getCotacao(
        @Query("access_key")access_key: String
    ): Call<Live>

    @GET("list?access_key")
    fun getListaMoedas(
        @Query("access_key")access_key: String
    ): Call<ListMoeda>

}