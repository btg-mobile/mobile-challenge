package com.gft.data.repository

import android.net.NetworkInfo
import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable
import java.lang.Error

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource,
    private val networkInfo: NetworkInfo
) : CurrencyRepository {
    override fun getAllLabels(): Flowable<CurrencyLabelList> {
        if (networkInfo.isConnected)
            return currencyRemoteDataSource.getLabels()
        throw Error()
    }

    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }
}