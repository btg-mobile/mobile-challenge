package com.br.cambio.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.br.cambio.data.model.Currency

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCurrencyList(currency: List<Currency>)

    @Query("SELECT * FROM Currency")
    suspend fun getCurrencyList(): List<Currency>
}