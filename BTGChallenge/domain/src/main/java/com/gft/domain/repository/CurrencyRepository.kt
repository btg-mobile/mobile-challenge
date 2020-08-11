package com.gft.domain.repository

import com.gft.domain.entities.CurrencyList
import io.reactivex.Flowable

interface CurrencyRepository {
    fun getAllLabels(): Flowable<CurrencyList>

    fun convert(from: String, to: String, value: Double): Double
}