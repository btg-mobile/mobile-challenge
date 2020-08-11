package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable

interface CurrencyRemoteDataSource {
    fun getLabels() : Flowable<CurrencyLabelList>

    fun getValues() : Flowable<CurrencyValueList>
}