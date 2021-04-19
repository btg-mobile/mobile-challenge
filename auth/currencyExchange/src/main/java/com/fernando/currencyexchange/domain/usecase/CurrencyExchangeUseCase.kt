package com.fernando.currencyexchange.domain.usecase

import com.fernando.currencyexchange.domain.repository.CurrencyExchangeRepositoryContract
import javax.inject.Inject

class CurrencyExchangeUseCase @Inject constructor(private val currencyExchangeRepositoryViewContract: CurrencyExchangeRepositoryContract) :
    CurrencyExchangeUseCaseContract {

    override suspend fun getCurrency() = currencyExchangeRepositoryViewContract.getCurrency()
}