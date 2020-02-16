package io.felipeandrade.data

import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper
import io.felipeandrade.domain.CurrencyModel

class CurrencyRepository(
    private val currencyApi: CurrencyApi,
    private val currencyMapper: CurrencyMapper
) {
    suspend fun loadSupportedCurrencies(): List<CurrencyModel> {
        return try {
            val response = currencyApi.loadSupportedCurrencies(BuildConfig.API_KEY)
            currencyMapper.mapSupportedCurrencies(response)

        } catch (e: Exception) {
            e.printStackTrace()
            emptyList()
        }
    }

}
