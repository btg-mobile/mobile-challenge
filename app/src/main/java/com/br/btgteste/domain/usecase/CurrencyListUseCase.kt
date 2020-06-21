package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyList
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyListUseCase(
    private val currenciesRepository: CurrenciesRepository
): BaseUseCase<CurrencyList, Any, List<Currency>>() {

    override suspend fun run(request: Any?): CurrencyList = currenciesRepository.getCurrencies()

    override fun interceptor(
        request: Any?,
        response: CurrencyList,
        onResult: (ApiResult<List<Currency>>) -> Unit
    ) = onResult(ApiResult.Success(response.currencies.payloads))
}