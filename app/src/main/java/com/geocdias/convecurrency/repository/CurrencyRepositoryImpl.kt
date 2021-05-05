package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.data.network.CurrencyApi
import com.geocdias.convecurrency.util.ResourceWrapper

class CurrencyRepositoryImpl(
    val currencyDao: CurrencyDao,
    val exchangeRateDao: ExchangeRateDao,
    val currencyApi: CurrencyApi
): CurrencyRepository {

    override suspend fun fetchCurrencies(): LiveData<ResourceWrapper<List<CurrencyEntity>>> {
        TODO("Not yet implemented")
    }

    override suspend fun getRate(fromCurrency: String, toCurrency: String): LiveData<ResourceWrapper<ExchangeRateEntity>> {
        TODO("Not yet implemented")
    }

    override suspend fun getCurrencyByCode(code: String): LiveData<ResourceWrapper<CurrencyEntity>> {
        TODO("Not yet implemented")
    }

    override suspend fun getCurrencyByName(name: String): LiveData<ResourceWrapper<List<CurrencyEntity>>> {
        TODO("Not yet implemented")
    }

    override suspend fun getAllCurrencyCodes(): LiveData<ResourceWrapper<List<String>>> {
        TODO("Not yet implemented")
    }
}
