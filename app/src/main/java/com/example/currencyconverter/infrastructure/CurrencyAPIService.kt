package com.example.currencyconverter.infrastructure

import io.reactivex.Observable
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

data class ListRetrofitResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String,String>)

data class LiveRetrofitResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val quotes: Map<String,Double>)


interface CurrencyAPIService {

    @GET("list?access_key=$API_KEY")
    fun getCurrencyList(): Observable<ListRetrofitResponse>

    @GET("live?access_key=$API_KEY")
    fun getLiveQuotes(): Observable<LiveRetrofitResponse>


    companion object {

        fun create(): CurrencyAPIService {
            val interceptor = HttpLoggingInterceptor()
            interceptor.level = HttpLoggingInterceptor.Level.BODY

            val client = OkHttpClient.Builder()
            client.addInterceptor(interceptor)

            val retrofit = Retrofit.Builder()
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .baseUrl(BASE_URL)
                .client(client.build())
                .build()

            return retrofit.create(CurrencyAPIService::class.java)
        }
    }
}