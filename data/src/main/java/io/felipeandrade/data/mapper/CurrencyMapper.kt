package io.felipeandrade.data.mapper

import io.felipeandrade.data.api.response.SupportedCurrenciesResponse
import io.felipeandrade.domain.CurrencyModel

class CurrencyMapper {
    fun mapSupportedCurrencies(response: SupportedCurrenciesResponse): List<CurrencyModel> {

        val result: MutableList<CurrencyModel> = mutableListOf()

        return result
    }
}