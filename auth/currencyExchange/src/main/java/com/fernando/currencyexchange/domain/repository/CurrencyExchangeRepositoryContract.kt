package com.fernando.currencyexchange.domain.repository

import com.fernando.currencyexchange.model.CurrencyExchange
import retrofit2.Response

interface CurrencyExchangeRepositoryContract {
    suspend fun getCurrency(): Response<CurrencyExchange>
}