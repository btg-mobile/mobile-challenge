package com.fernando.currencylist.data.datasource

import com.fernando.currencylist.model.CurrencyList
import retrofit2.Response

interface CurrencyListRemoteDataSourceContract {
    suspend fun getCurrency(): Response<CurrencyList>
}