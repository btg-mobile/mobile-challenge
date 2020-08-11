package com.gft.data.repository

import android.net.NetworkInfo
import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.domain.entities.CurrencyList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable
import java.lang.Error

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource,
    private val networkInfo: NetworkInfo
) : CurrencyRepository {
    override fun getAllLabels(): Flowable<CurrencyList> {
        if (networkInfo.isConnected)
            return currencyRemoteDataSource.getAllLabels()
        throw Error()
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }
}