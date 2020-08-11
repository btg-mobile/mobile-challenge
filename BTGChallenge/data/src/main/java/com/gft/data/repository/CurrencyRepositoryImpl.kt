package com.gft.data.repository

import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.repository.CurrencyRepository

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource
) : CurrencyRepository {
    override fun getAllLabels(): List<CurrencyLabel> {
        TODO("Not yet implemented")
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }
}