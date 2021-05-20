package com.example.currencyapp.database.dao

import androidx.room.*
import com.example.currencyapp.database.entity.Currency

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun updateAllRate(currencies: List<Currency>)

    @Query("SELECT * FROM currency_table")
    suspend fun getAllCurrencies() : List<Currency>

}