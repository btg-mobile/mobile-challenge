package io.felipeandrade.data

import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper
import java.util.*

class CurrencyRepository(
    private val currencyApi: CurrencyApi,
    private val currencyMapper: CurrencyMapper
) {
    fun loadAll(): List<Currency> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

}
