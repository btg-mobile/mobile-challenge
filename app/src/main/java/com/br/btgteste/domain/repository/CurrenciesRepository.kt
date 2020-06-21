package com.br.btgteste.domain.repository

import com.br.btgteste.data.model.CurrencyList
import com.br.btgteste.data.model.CurrencyLive

interface CurrenciesRepository {
    suspend fun getCurrencies() : CurrencyList
    suspend fun convertCurrencies() : CurrencyLive
}