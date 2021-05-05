package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.util.ResourceWrapper

interface CurrencyRepository {
    suspend fun fetchCurrencies(): LiveData<ResourceWrapper<List<CurrencyEntity>>>
    suspend fun getRate(fromCurrency: String, toCurrency: String): LiveData<ResourceWrapper<ExchangeRateEntity>>
    suspend fun getCurrencyByCode(code: String): LiveData<ResourceWrapper<CurrencyEntity>>
    suspend fun getCurrencyByName(name: String): LiveData<ResourceWrapper<List<CurrencyEntity>>>
    suspend fun getAllCurrencyCodes(): LiveData<ResourceWrapper<List<String>>>
}
