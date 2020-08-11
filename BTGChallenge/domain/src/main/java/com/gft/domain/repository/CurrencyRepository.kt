package com.gft.domain.repository

import com.gft.domain.entities.CurrencyLabelList
import io.reactivex.Flowable

interface CurrencyRepository {
    fun getAllLabels(): Flowable<CurrencyLabelList>

    fun convert(from: String, to: String, value: Double): Double
}