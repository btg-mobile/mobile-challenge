package com.gft.data.repository

import android.net.NetworkInfo
import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.repository.CurrencyRepository

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource,
    private val networkInfo: NetworkInfo
) : CurrencyRepository {
    override fun getAllLabels(): List<CurrencyLabel> {
        return if (networkInfo.isConnected)
            currencyRemoteDataSource.getAllLabels()
        else currencyLocalDataSource.getAllLabels()
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }
}