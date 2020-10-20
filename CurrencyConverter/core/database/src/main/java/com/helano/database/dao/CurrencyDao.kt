package com.helano.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.helano.database.entities.Currency

@Dao
interface CurrencyDao {

    @Query("SELECT * FROM currencies ORDER BY id")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(data: List<Currency>)

    @Query("DELETE FROM currencies")
    fun deleteAll()

    @Query("SELECT * FROM currencies WHERE id = :id")
    fun getCurrency(id: String): Currency

    @Query("SELECT count(*) FROM currencies")
    fun getSize(): Int
}