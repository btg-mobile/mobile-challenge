package com.br.mpc.desafiobtg.utils

import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RetrofitUtil {
    companion object {
        private fun getRetrofit(): Retrofit {
            return Retrofit.Builder()
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl("http://api.currencylayer.com/")
                .client(getClient())
                .build()
        }

        private fun getClient(): OkHttpClient {
            return OkHttpClient.Builder()
                .addNetworkInterceptor { chain ->
                    val originalRequest = chain.request()
                    val newUrlBuilder = originalRequest.url.newBuilder()
                    val newUrl = newUrlBuilder.addQueryParameter(
                        "access_key",
                        "f402c510eb7e91eb05707bc0bceb94a2"
                    ).build()
                    val newRequest = originalRequest.newBuilder().url(newUrl).build()
                    chain.proceed(newRequest)
                }
                .addInterceptor(getLoggingInterceptor())
                .callTimeout(60, TimeUnit.SECONDS)
                .connectTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .build()
        }

        private fun getLoggingInterceptor() =
            HttpLoggingInterceptor().apply {
                this.setLevel(HttpLoggingInterceptor.Level.BODY)
            }

        fun <S> createService(service: Class<S>) =
            getRetrofit().create(service)
    }
}