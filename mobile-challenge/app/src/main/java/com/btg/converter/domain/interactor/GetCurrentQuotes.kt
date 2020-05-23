package com.btg.converter.domain.interactor

import com.btg.converter.domain.boundary.CurrencyRepository


class GetCurrentQuotes constructor(
    private val currencyRepository: CurrencyRepository
) {

    suspend fun execute() = currencyRepository.getCurrentQuotes()
}