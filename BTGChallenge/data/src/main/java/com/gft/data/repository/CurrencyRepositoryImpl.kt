package com.gft.data.repository

import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource
) : CurrencyRepository {
    override fun getLabels(): Flowable<CurrencyLabelList> {
        return currencyRemoteDataSource.getLabels()
    }

    override fun getValues(): Flowable<CurrencyValueList> {
        return currencyRemoteDataSource.getValues()
    }

}