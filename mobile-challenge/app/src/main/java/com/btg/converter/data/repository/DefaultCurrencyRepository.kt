package com.btg.converter.data.repository

import com.btg.converter.data.client.ApiClient
import com.btg.converter.domain.boundary.CurrencyRepository

class DefaultCurrencyRepository constructor(
    private val apiClient: ApiClient
) : CurrencyRepository {

    override suspend fun getCurrencyList() = apiClient.getCurrencyList()?.toDomainObject()
    override suspend fun getCurrentQuotes() = apiClient.getCurrentQuotes()?.toDomainObject()
}