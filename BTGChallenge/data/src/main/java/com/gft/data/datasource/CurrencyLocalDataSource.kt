package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabel

interface CurrencyLocalDataSource {
    suspend fun getAll() : List<CurrencyLabel>
    suspend fun getByString(string: String) : CurrencyLabel
}