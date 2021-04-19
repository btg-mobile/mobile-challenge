package com.fernando.currencyexchange.domain.repository

import com.fernando.currencyexchange.data.datasource.CurrencyExchangeRemoteDataSourceContract
import javax.inject.Inject

class CurrencyExchangeRepository @Inject constructor(private val currencyExchangeRemoteDataSourceViewContract: CurrencyExchangeRemoteDataSourceContract) :
    CurrencyExchangeRepositoryContract {
    override suspend fun getCurrency() = currencyExchangeRemoteDataSourceViewContract.getCurrency()
}

