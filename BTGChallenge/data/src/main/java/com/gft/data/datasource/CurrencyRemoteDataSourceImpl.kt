package com.gft.data.datasource

import com.gft.data.api.CurrencyApi
import com.gft.data.mapper.CurrencyDataEntityMapper
import com.gft.domain.entities.CurrencyList
import io.reactivex.Flowable

class CurrencyRemoteDataSourceImpl(private val currencyApi: CurrencyApi) :
    CurrencyRemoteDataSource {

    private val mapper =  CurrencyDataEntityMapper()

    override fun getAllLabels(): Flowable<CurrencyList> {
        return currencyApi.getAll().map { mapper.mapToEntity(it) }
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }

}