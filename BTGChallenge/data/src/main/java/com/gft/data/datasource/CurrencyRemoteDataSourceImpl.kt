package com.gft.data.datasource

import com.gft.data.api.CurrencyApi
import com.gft.data.mapper.CurrencyDataEntityMapper
import com.gft.data.utils.SafeApiRequest
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource
import io.reactivex.Flowable

class CurrencyRemoteDataSourceImpl(private val currencyApi: CurrencyApi) :
    CurrencyRemoteDataSource, SafeApiRequest() {

    private val mapper = CurrencyDataEntityMapper()

    override suspend fun getLabels(): Resource<CurrencyLabelList> {
        return apiRequest { currencyApi.getLabels() }
    }

    override fun getValues(): Flowable<CurrencyValueList> {
        return currencyApi.getValues().map { mapper.mapToEntity(it) }
    }

}