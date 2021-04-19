package com.fernando.currencylist.data.api

import com.fernando.currencylist.model.CurrencyList
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyListService {

    @GET("list?access_key=48125b5d15ed2d98ad9ac92bd9f98ac8")
    suspend fun getCurrency(): Response<CurrencyList>
}