package com.gft.data.datasource

import com.gft.domain.entities.CurrencyValue

interface CurrencyRemoteDataSource {
    suspend fun getByString(string: String) : CurrencyValue
}