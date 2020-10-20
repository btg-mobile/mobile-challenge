package com.helano.repository

import com.helano.database.entities.Currency
import com.helano.repository.data.LocalDataSource
import com.helano.repository.data.RemoteDataSource

class CurrencyRepositoryImpl(
    private val local: LocalDataSource,
    private val remote: RemoteDataSource
) : CurrencyRepository {

    override suspend fun currencies(): Map<String, String> {
        if (local.isCurrenciesEmpty()) {
            val response = remote.currencies()
            if (response.success) {
                local.currencies = response.currencies.map { Currency(0, it.key, it.value) }
            } else {
                // TODO: Handle fail response
            }
        }
        return local.currencies.map { it.currencyCode to it.currencyName }.toMap()
    }
}