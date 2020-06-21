package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyLive
import com.br.btgteste.domain.helper.QuotesHelper
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyLiveUseCase(
    private val currenciesRepository: CurrenciesRepository):
    BaseUseCase<CurrencyLive, CurrencyLiveUseCase.Params, Double>() {

    data class Params(val amount: Double, val from : Currency, val to : Currency)

    override fun interceptor(
        request: Params?,
        response: CurrencyLive,
        onResult: (ApiResult<Double>) -> Unit
    ) {
        request?.apply {
            onResult(ApiResult.Success(QuotesHelper.convert(
                request.amount, request.from, request.to, response.quotes.payloads)))
        }
    }

    override suspend fun run(request: Params?) = currenciesRepository.convertCurrencies()
}