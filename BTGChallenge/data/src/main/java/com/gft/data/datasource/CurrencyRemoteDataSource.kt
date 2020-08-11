package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabelList
import io.reactivex.Flowable

interface CurrencyRemoteDataSource {
    fun getAllLabels() : Flowable<CurrencyLabelList>

    fun convert(from: String, to: String, value: Double) : Double
}