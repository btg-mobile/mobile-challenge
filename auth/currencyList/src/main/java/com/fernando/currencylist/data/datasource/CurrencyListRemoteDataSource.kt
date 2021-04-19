package com.fernando.currencylist.data.datasource

import com.fernando.currencylist.data.api.CurrencyListService
import javax.inject.Inject

class CurrencyListRemoteDataSource @Inject constructor(private val currencyListService: CurrencyListService) :
    CurrencyListRemoteDataSourceContract {
    override suspend fun getCurrency() = currencyListService.getCurrency()
}