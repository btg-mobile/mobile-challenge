package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabel

interface CurrencyLocalDataSource {
    fun getAllLabels() : List<CurrencyLabel>

    fun convert(from: String, to: String, value: Double) : Double
}