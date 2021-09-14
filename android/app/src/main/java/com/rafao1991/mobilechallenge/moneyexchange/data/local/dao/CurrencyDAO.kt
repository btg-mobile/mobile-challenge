package com.rafao1991.mobilechallenge.moneyexchange.data.local.dao

import androidx.room.*
import com.rafao1991.mobilechallenge.moneyexchange.data.local.entity.CurrencyEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface CurrencyDAO {

    @Query("SELECT * FROM currency")
    fun getCurrencies(): Flow<List<CurrencyEntity>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(currency: CurrencyEntity)
}