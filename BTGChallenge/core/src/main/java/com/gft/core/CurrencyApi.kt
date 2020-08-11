package com.gft.core

import com.gft.data.model.CurrenciesLabelModel
import io.reactivex.Observable
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {
    @GET("list")
    fun getAll(@Query("access_key") accessKey: String):
            Call<CurrenciesLabelModel>

    companion object {
        fun create(): CurrencyApi {

            val retrofit = Retrofit.Builder()
                .addCallAdapterFactory(
                    RxJava2CallAdapterFactory.create()
                )
                .addConverterFactory(
                    GsonConverterFactory.create()
                )
                .baseUrl("http://api.currencylayer.com/")
                .build()

            return retrofit.create(CurrencyApi::class.java)
        }
    }

}
