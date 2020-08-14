package com.kaleniuk2.conversordemoedas.data.repository

import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.remote.CurrencyRemoteDataSource

class CurrencyRepositoryImpl : CurrencyRepository {
    override fun getListCurrency(callback: (DataWrapper<List<Currency>>) -> Unit) {
        CurrencyRemoteDataSource<DataWrapper<List<Currency>>> {
            callback(it)
        }.execute(CurrencyRemoteDataSource.END_POINT.LIST)
    }

}