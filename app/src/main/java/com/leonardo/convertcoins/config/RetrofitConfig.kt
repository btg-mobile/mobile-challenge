package com.leonardo.convertcoins.config

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitConfig {
    private val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl("http://api.currencylayer.com/")
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    fun currencyService(): CurrencyService = retrofit.create(CurrencyService::class.java)
}