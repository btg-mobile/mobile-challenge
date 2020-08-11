package com.gft.domain.repository

import com.gft.domain.entities.CurrencyLabel

interface CurrencyRepository {
    fun getAllLabels() : List<CurrencyLabel>

    fun convert(from: String, to: String, value: Double) : Double
}