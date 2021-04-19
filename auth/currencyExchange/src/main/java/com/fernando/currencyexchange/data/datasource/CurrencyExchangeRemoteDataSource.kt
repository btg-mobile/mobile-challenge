package com.fernando.currencyexchange.data.datasource

import com.fernando.currencyexchange.data.api.CurrencyExchangeService
import javax.inject.Inject

class CurrencyExchangeRemoteDataSource @Inject constructor(private val currencyExchangeService: CurrencyExchangeService) :
    CurrencyExchangeRemoteDataSourceContract {
    override suspend fun getCurrency() = currencyExchangeService.getCurrency()
}