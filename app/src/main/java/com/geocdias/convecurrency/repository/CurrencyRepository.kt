package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.util.Resource

interface CurrencyRepository {
    fun fetchCurrencies(): LiveData<Resource<List<CurrencyModel>>>
    suspend fun getRate(fromCurrency: String, toCurrency: String): LiveData<Resource<ExchangeRateEntity>>
    suspend fun getCurrencyByCode(code: String): LiveData<Resource<CurrencyEntity>>
    suspend fun getCurrencyByName(name: String): LiveData<Resource<List<CurrencyEntity>>>
    suspend fun getAllCurrencyCodes(): LiveData<Resource<List<String>>>
}
