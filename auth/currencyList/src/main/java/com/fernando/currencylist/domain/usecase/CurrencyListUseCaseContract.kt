package com.fernando.currencylist.domain.usecase

import com.fernando.currencylist.model.CurrencyList
import retrofit2.Response

interface CurrencyListUseCaseContract {
    suspend fun getCurrency(): Response<CurrencyList>
}