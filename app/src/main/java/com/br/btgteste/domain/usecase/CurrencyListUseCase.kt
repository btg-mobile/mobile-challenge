package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyListDTO
import com.br.btgteste.domain.datasource.CurrencyDataSource
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyListUseCase(
    private val currenciesRepository: CurrenciesRepository,
    private val currencyDataSource: CurrencyDataSource
): BaseUseCase<Any, Any, List<Currency>>() {

    override suspend fun run(request: Any?): Any {
        val currencies = currencyDataSource.getCurrencies()
        return if (currencies.isEmpty()) {
            currenciesRepository.getCurrencies()
        } else {
            currencies
        }
    }

    override fun interceptor(
        request: Any?,
        response: Any,
        onResult: (ApiResult<List<Currency>>) -> Unit
    ) {
        when(response) {
            is List<*> -> {
                onResult(ApiResult.Success(response.filterIsInstance(Currency::class.java)))
            }
            is CurrencyListDTO -> {
                if (response.success) {
                    runAsync { currencyDataSource.updateCurrencies(response.currencies.payloads) }
                    onResult(ApiResult.Success(response.currencies.payloads))
                }
                else { onResult(ApiResult.Error(Throwable(response.error?.info))) }
            }
        }
    }
}
