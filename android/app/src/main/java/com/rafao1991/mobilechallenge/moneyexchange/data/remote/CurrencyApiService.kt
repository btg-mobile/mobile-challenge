package com.rafao1991.mobilechallenge.moneyexchange.data.remote

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET

private const val BASE_URL = "https://btg-mobile-challenge.herokuapp.com"

private val interceptor = run {
    val httpLoggingInterceptor = HttpLoggingInterceptor()
    httpLoggingInterceptor.apply {
        httpLoggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
    }
}

private val client = OkHttpClient
    .Builder()
    .addInterceptor(interceptor)
    .build()

private val moshi = Moshi
    .Builder()
    .add(KotlinJsonAdapterFactory())
    .build()

private val retrofit = Retrofit
    .Builder()
    .addConverterFactory(MoshiConverterFactory.create(moshi))
    .baseUrl(BASE_URL)
    .client(client)
    .build()

object CurrencyApi {
    val service : CurrencyApiService by lazy {
        retrofit.create(CurrencyApiService::class.java) }
}

interface CurrencyApiService {
    @GET("list")
    suspend fun getList(): CurrencyList

    @GET("live")
    suspend fun getLiveQuotes(): CurrencyLiveQuotes
}