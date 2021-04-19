package com.fernando.currencyexchange.data.datasource

import com.fernando.currencyexchange.model.CurrencyExchange
import retrofit2.Response

interface CurrencyExchangeRemoteDataSourceContract {
    suspend fun getCurrency(): Response<CurrencyExchange>
}