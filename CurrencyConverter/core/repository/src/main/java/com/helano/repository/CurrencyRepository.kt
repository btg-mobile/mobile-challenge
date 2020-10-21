package com.helano.repository

import com.helano.shared.model.Currency

interface CurrencyRepository {

    suspend fun currencies(): List<Currency>

    suspend fun getCurrency(code: String): Currency
}