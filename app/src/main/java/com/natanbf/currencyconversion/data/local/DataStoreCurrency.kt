package com.natanbf.currencyconversion.data.local

import com.natanbf.currencyconversion.domain.model.DataStoreModel
import kotlinx.coroutines.flow.Flow

interface DataStoreCurrency {
    suspend fun save(completed: DataStoreModel.() -> DataStoreModel)
    fun read(): Flow<DataStoreModel>
}
