package com.fernando.currencylist.domain.repository

import com.fernando.currencylist.model.CurrencyList
import retrofit2.Response

interface CurrencyListRepositoryContract {
    suspend fun getCurrency(): Response<CurrencyList>
}