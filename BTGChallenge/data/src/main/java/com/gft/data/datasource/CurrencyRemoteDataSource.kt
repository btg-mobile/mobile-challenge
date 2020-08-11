package com.gft.data.datasource

import com.gft.domain.entities.CurrencyList
import io.reactivex.Flowable

interface CurrencyRemoteDataSource {
    fun getAllLabels() : Flowable<CurrencyList>

    fun convert(from: String, to: String, value: Double) : Double
}