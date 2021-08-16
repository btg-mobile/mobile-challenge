package com.br.cambio.data.datasource

import android.support.annotation.WorkerThread
import android.util.Log
import androidx.lifecycle.LiveData
import com.br.cambio.data.api.Api
import com.br.cambio.data.local.CurrencyDao
import com.br.cambio.data.local.PriceDao
import com.br.cambio.data.mapper.CurrencyToDomainMapper
import com.br.cambio.data.mapper.PriceToDomainMapper
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price
import com.br.cambio.data.model.Exchange
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain
import com.br.cambio.utils.Extensions
import kotlinx.coroutines.flow.flow

class RemoteDataSourceImpl(
    private val service: Api
) : RemoteDataSource, CurrencyDao, PriceDao {

    private val mapperCurrency = CurrencyToDomainMapper()
    private val mapperPrice = PriceToDomainMapper()

    override suspend fun getCurrencies(): List<CurrencyDomain>? {
        val response = service.getCurrency()

        return if (response.isSuccessful) {
            if (getCurrencyList() == null) {
                insertCurrencyList(convertCurrency(response.body()?.currencies))
                checkBodyCurrency(getCurrencyList())
            } else {
                checkBodyCurrency(getCurrencyList())
            }
        } else {
            Log.d("erro no request código", response.code().toString())
            null
        }
    }

    private fun convertCurrency(data: HashMap<String, String>?): List<Currency> {
        val list: MutableList<Currency> = mutableListOf()

        data?.forEach { (key, value) ->
            list.add(
                Currency(
                    key,
                    value
                )
            )
        }

        return list
    }

    private fun checkBodyCurrency(data: List<Currency>?): List<CurrencyDomain> {
        if (data == null) {
            return listOf()
        } else {
            val domain: MutableList<CurrencyDomain> = mutableListOf()
            data.forEach { (key, value) ->
                domain.add(
                    mapperCurrency.map(
                        Currency(
                            key,
                            value
                        )
                    )
                )
            }
            return domain
        }
    }

    override suspend fun getPrices(): List<PriceDomain>? {
        val response = service.getPrice()

        return if (response.isSuccessful) {

            if (getPriceList() == null) {
                insertPriceList(convertPrice(response.body()?.quotes))
                checkBodyPrice(getPriceList())
            } else {
                checkBodyPrice(getPriceList())
            }
        } else {
            Log.d("erro no request código", response.code().toString())
            null
        }
    }

    private fun convertPrice(data: HashMap<String, Double>?): List<Price> {
        val list: MutableList<Price> = mutableListOf()

        data?.forEach { (key, value) ->
            list.add(
                Price(
                    key,
                    value
                )
            )
        }

        return list
    }

    private fun checkBodyPrice(data: List<Price>?): List<PriceDomain> {
        if (data == null) {
            return listOf()
        } else {
            val domain: MutableList<PriceDomain> = mutableListOf()
            data.forEach { (key, value) ->
                domain.add(
                    mapperPrice.map(
                        Price(
                            key,
                            value
                        )
                    )
                )
            }
            return domain
        }
    }

    override suspend fun insertCurrencyList(currency: List<Currency>) {
        insertCurrencyList(currency)
    }

    override suspend fun getCurrencyList(): List<Currency> {
        return getCurrencyList()
    }

    override suspend fun insertPriceList(price: List<Price>) {
        insertPriceList(price)
    }

    override suspend fun getPriceList(): List<Price> {
        return getPriceList()
    }
}