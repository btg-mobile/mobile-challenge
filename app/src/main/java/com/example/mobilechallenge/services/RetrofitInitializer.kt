package com.example.mobilechallenge.services

import com.example.mobilechallenge.utils.Constants
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitInitializer {

    private val retrofit = Retrofit.Builder()
        .baseUrl(Constants.BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    fun getRemoteServices(): RemoteServices = retrofit.create(RemoteServices::class.java)
}