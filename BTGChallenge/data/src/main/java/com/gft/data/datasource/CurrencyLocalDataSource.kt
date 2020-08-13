package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.entities.CurrencyValue
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable

interface CurrencyLocalDataSource {
    fun getAllLabels() : List<CurrencyLabel>

    fun getValues() : Flowable<CurrencyValueList>
}