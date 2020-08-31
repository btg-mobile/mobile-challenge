package com.example.convertermoeda.retrofit.service

import com.example.convertermoeda.model.Live
import retrofit2.Call
import retrofit2.http.*

interface ServiceApi {


    @GET("live?access_key&currencies=USD,AUD,CAD,PLN,MXN&format=1")
    fun getCotacao(
        @Query("access_key")access_key: String
    ): Call<Live>

    @GET("list?access_key")
    fun getListaCambio(
        @Query("access_key")access_key: String
    ): Call<Live>

}