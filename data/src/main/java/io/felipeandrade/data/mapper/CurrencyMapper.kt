package io.felipeandrade.data.mapper

import io.felipeandrade.data.api.response.SupportedCurrenciesResponse
import io.felipeandrade.domain.CurrencyModel

class CurrencyMapper {
    fun mapSupportedCurrencies(response: SupportedCurrenciesResponse): List<CurrencyModel> {

        val result: MutableList<CurrencyModel> = mutableListOf()

        response.currencies.forEach { item ->
            result.add(
                CurrencyModel(
                    symbol = item.key,
                    name = item.value
                )
            )
        }

        return result
    }
}