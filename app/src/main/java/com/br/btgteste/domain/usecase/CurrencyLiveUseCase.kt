package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyLiveDTO
import com.br.btgteste.domain.helper.QuotesHelper
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyLiveUseCase(
    private val currenciesRepository: CurrenciesRepository):
    BaseUseCase<CurrencyLiveDTO, CurrencyLiveUseCase.Params, Double>() {

    data class Params(val amount: Double, val from : Currency, val to : Currency)

    override fun interceptor(
        request: Params?,
        response: CurrencyLiveDTO,
        onResult: (ApiResult<Double>) -> Unit
    ) {
        if (response.success) {
            request?.apply {
                onResult(ApiResult.Success(QuotesHelper.convert(
                    request.amount, request.from, request.to, response.quotes.payloads)))
            }
        } else { onResult(ApiResult.Error(Throwable(response.error?.info))) }
    }

    override suspend fun run(request: Params?) = currenciesRepository.convertCurrencies()
}