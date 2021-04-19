package com.fernando.currencyexchange.domain.usecase

import com.fernando.currencyexchange.model.CurrencyExchange
import retrofit2.Response

interface CurrencyExchangeUseCaseContract {
    suspend fun getCurrency(): Response<CurrencyExchange>
}