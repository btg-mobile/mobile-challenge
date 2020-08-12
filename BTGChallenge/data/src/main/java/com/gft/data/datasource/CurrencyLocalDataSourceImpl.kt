package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabel

class CurrencyLocalDataSourceImpl() :
    CurrencyLocalDataSource {
    override fun getAllLabels(): List<CurrencyLabel> {
        TODO("Not yet implemented")
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }
}