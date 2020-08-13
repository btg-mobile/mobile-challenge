package com.gft.domain.repository

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable

interface CurrencyRepository {
    fun getLabels(): Flowable<CurrencyLabelList>

    fun getValues(): Flowable<CurrencyValueList>
}