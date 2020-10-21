package com.helano.repository.data

import com.helano.database.dao.CurrencyDao
import com.helano.database.dao.CurrencyQuoteDao
import com.helano.shared.model.Currency
import javax.inject.Inject

class LocalDataSource @Inject constructor(
    private val currencyDao: CurrencyDao,
    private val currencyQuoteDao: CurrencyQuoteDao
) {

    var currencies: List<Currency>
        get() = currencyDao.getAll()
        set(value) = currencyDao.insertAll(value)

    fun getCurrency(code: String): Currency {
        return currencyDao.getCurrency(code)
    }

    fun isCurrenciesEmpty() = currencyDao.getSize() == 0
}