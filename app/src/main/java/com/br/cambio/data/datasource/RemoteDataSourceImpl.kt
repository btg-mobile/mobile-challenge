package com.br.cambio.data.datasource

import android.util.Log
import com.br.cambio.data.api.Api
import com.br.cambio.data.mapper.CurrencyToDomainMapper
import com.br.cambio.data.mapper.PriceToDomainMapper
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price
import com.br.cambio.data.model.Result
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain
import com.br.cambio.utils.Extensions

class RemoteDataSourceImpl(
    private val service: Api
) : RemoteDataSource {

    private val mapperCurrency = CurrencyToDomainMapper()
    private val mapperPrice = PriceToDomainMapper()

    override suspend fun getCurrencies(): List<CurrencyDomain>? {
        val response = service.getCurrency()

        return if (response.isSuccessful) {
            checkBodyCurrency(response.body())
        } else {
            Log.d("erro no request código", response.code().toString())
            null
        }
    }

    private fun checkBodyCurrency(data: Result?): List<CurrencyDomain> {
        if (Extensions.isNullOrEmpty(data) || data?.currencies.isNullOrEmpty()) {
            return listOf()
        } else {
            val domain: MutableList<CurrencyDomain> = mutableListOf()
            data?.currencies?.forEach { (key, value) ->
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
            checkBodyPrice(response.body())
        } else {
            Log.d("erro no request código", response.code().toString())
            null
        }
    }

    private fun checkBodyPrice(data: Result?): List<PriceDomain> {
        if (Extensions.isNullOrEmpty(data) || data?.quotes.isNullOrEmpty()) {
            return listOf()
        } else {
            val domain: MutableList<PriceDomain> = mutableListOf()
            data?.quotes?.forEach { (key, value) ->
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
}