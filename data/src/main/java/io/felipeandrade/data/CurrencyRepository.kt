package io.felipeandrade.data

import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper

class CurrencyRepository(
    private val currencyApi: CurrencyApi,
    private val currencyMapper: CurrencyMapper
) {

}
