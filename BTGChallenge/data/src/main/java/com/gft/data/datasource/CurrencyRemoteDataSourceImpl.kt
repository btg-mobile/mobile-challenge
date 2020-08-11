package com.gft.data.datasource

import com.gft.data.api.CurrencyApi
import com.gft.data.mapper.CurrencyDataEntityMapper
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable

class CurrencyRemoteDataSourceImpl(private val currencyApi: CurrencyApi) :
    CurrencyRemoteDataSource {

    private val mapper = CurrencyDataEntityMapper()

    override fun getLabels(): Flowable<CurrencyLabelList> {
        return currencyApi.getLabels().map { mapper.mapToEntity(it) }
    }

    override fun getValues(): Flowable<CurrencyValueList> {
        return currencyApi.getValues().map { mapper.mapToEntity(it) }
    }

}