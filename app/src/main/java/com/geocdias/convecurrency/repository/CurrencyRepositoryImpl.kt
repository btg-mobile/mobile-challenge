package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.map
import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.data.network.CurrencyClient
import com.geocdias.convecurrency.data.network.response.performGetOperation
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.util.Constants
import com.geocdias.convecurrency.util.CurrencyMapper
import com.geocdias.convecurrency.util.Resource
import javax.inject.Inject

class CurrencyRepositoryImpl @Inject constructor(
    val currencyDao: CurrencyDao,
    val exchangeRateDao: ExchangeRateDao,
    val currencyClient: CurrencyClient,
    val mapper: CurrencyMapper
) : CurrencyRepository {

    override fun fetchCurrencies(): LiveData<Resource<List<CurrencyModel>>> {
        return performGetOperation(
            databaseQuery = { fetchCurrenciesFromDb() },
            networkCall = { currencyClient.fetchCurrencies(Constants.KEY) },
            saveCallResult = { currencyListRespose ->
                val currencies =  mapper.remoteListToDbMapper.map(currencyListRespose)
                currencyDao.insertCurrencyList(currencies)
            }
        )
    }

    fun fetchCurrenciesFromDb() = currencyDao.observeCurrencyList().map {
        mapper.dbToDomainMapper.mapList(it)
    }

    override suspend fun getRate(
        fromCurrency: String,
        toCurrency: String
    ): LiveData<Resource<ExchangeRateEntity>> {
        TODO("Not yet implemented")
    }

    override suspend fun getCurrencyByCode(code: String): LiveData<Resource<CurrencyEntity>> {
        TODO("Not yet implemented")
    }

    override suspend fun getCurrencyByName(name: String): LiveData<Resource<List<CurrencyEntity>>> {
        TODO("Not yet implemented")
    }

    override suspend fun getAllCurrencyCodes(): LiveData<Resource<List<String>>> {
        TODO("Not yet implemented")
    }
}
