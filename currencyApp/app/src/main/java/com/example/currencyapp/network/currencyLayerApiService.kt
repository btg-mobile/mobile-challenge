package com.example.currencyapp.network

import com.example.currencyapp.network.service.CurrencyList
import com.example.currencyapp.network.service.CurrencyRate
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

private const val URL_BASE = "http://api.currencylayer.com/"

fun provideRetrofit() : Retrofit {
    return Retrofit.Builder()
        .baseUrl(URL_BASE)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
}

fun provideCurrencyListService(retrofit: Retrofit) : CurrencyList = retrofit.create(CurrencyList::class.java)
fun provideCurrencyLiveService(retrofit: Retrofit) : CurrencyRate = retrofit.create(CurrencyRate::class.java)