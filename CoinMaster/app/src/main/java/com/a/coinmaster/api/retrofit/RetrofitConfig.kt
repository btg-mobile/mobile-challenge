package com.a.coinmaster.api.retrofit

import com.a.coinmaster.BuildConfig
import com.google.gson.Gson
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RetrofitConfig {
    fun getBuild(): Retrofit =
        Retrofit
            .Builder()
            .baseUrl(BuildConfig.CURRENCYLAYER_URL_BASE)
            .addConverterFactory(GsonConverterFactory.create(Gson()))
            .client(getHttpClient())
            .build()

    private fun getHttpClient(): OkHttpClient =
        OkHttpClient
            .Builder()
            .addNetworkInterceptor(getInterceptor())
            .connectTimeout(TIMEOUT, TimeUnit.SECONDS)
            .readTimeout(TIMEOUT, TimeUnit.SECONDS)
            .writeTimeout(TIMEOUT, TimeUnit.SECONDS)
            .build()

    private fun getInterceptor(): HttpLoggingInterceptor =
        HttpLoggingInterceptor()
            .apply {
                level = getInterceptorLevel()
            }

    private fun getInterceptorLevel() =
        if (BuildConfig.DEBUG) {
            HttpLoggingInterceptor.Level.BODY
        } else {
            HttpLoggingInterceptor.Level.NONE
        }

    companion object {
        const val TIMEOUT = 60L
    }
}