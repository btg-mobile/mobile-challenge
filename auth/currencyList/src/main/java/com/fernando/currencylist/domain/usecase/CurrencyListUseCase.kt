package com.fernando.currencylist.domain.usecase

import com.fernando.currencylist.domain.repository.CurrencyListRepositoryContract
import javax.inject.Inject

class CurrencyListUseCase @Inject constructor(private val currencyListRepositoryViewContract: CurrencyListRepositoryContract) :
    CurrencyListUseCaseContract {

    override suspend fun getCurrency() = currencyListRepositoryViewContract.getCurrency()
}