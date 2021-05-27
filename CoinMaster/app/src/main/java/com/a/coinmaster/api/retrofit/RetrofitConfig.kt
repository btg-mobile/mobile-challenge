package com.a.coinmaster.api.retrofit

import com.a.coinmaster.BuildConfig
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RetrofitConfig {

    fun <T> getServiceApi(apiClass: Class<T>): T =
        getBuild().create(apiClass)

    fun getBuild(): Retrofit =
        Retrofit
            .Builder()
            .baseUrl(BuildConfig.CURRENCYLAYER_URL_BASE)
            .client(getHttpClient())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .addConverterFactory(GsonConverterFactory.create())
            .build()

    private fun getHttpClient(): OkHttpClient {
        return OkHttpClient
            .Builder()
            .addInterceptor(getHttpLoggingInterceptor())
            .connectTimeout(TIMEOUT, TimeUnit.SECONDS)
            .readTimeout(TIMEOUT, TimeUnit.SECONDS)
            .writeTimeout(TIMEOUT, TimeUnit.SECONDS)
            .build()
    }

    private fun getInterceptor() = Interceptor { chain: Interceptor.Chain ->
        val oldRequest = chain.request()
        val newUrl = oldRequest
            .url()
            .newBuilder()
            .addQueryParameter(ACCESS_KEY_QUERY, BuildConfig.CURRENCYLAYER_ACCESS_KEY)
            .build()
        val newRequest = oldRequest
            .newBuilder()
            .url(newUrl)
            .build()
        chain.proceed(newRequest)
    }

    private fun getHttpLoggingInterceptor(): HttpLoggingInterceptor =
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
        const val TIMEOUT = 30L
        const val ACCESS_KEY_QUERY = "access_key"
    }
}
