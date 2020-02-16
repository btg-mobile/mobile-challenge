package io.felipeandrade.data

import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper
import io.felipeandrade.domain.CurrencyModel

class CurrencyRepository(
    private val currencyApi: CurrencyApi,
    private val currencyMapper: CurrencyMapper
) {
    suspend fun loadSupportedCurrencies(): List<CurrencyModel> {
        val response = currencyApi.loadSupportedCurrencies(BuildConfig.API_KEY)
        return currencyMapper.mapSupportedCurrencies(response)
    }

}
