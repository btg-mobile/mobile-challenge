package com.fernando.currencylist.domain.repository

import com.fernando.currencylist.data.datasource.CurrencyListRemoteDataSourceContract
import javax.inject.Inject

class CurrencyListRepository @Inject constructor(private val currencyListRemoteDataSourceViewContract: CurrencyListRemoteDataSourceContract) :
    CurrencyListRepositoryContract {
    override suspend fun getCurrency() = currencyListRemoteDataSourceViewContract.getCurrency()
}

