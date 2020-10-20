package com.helano.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.helano.database.entities.CurrencyQuote

@Dao
interface CurrencyQuoteDao {

    @Query("SELECT * FROM quotes ORDER BY id")
    fun getAll(): List<CurrencyQuote>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(data: List<CurrencyQuote>)

    @Query("DELETE FROM quotes")
    fun deleteAll()

    @Query("SELECT * FROM quotes WHERE id = :id")
    fun getCurrency(id: String): CurrencyQuote

    @Query("SELECT count(*) FROM quotes")
    fun getSize(): Int
}