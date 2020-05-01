package com.example.mobile_challenge.db

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import com.example.mobile_challenge.model.CurrencyEntity

@Dao
interface CurrencyDao {
  @Query("SELECT * FROM currencyentity")
  fun getAll(): List<CurrencyEntity>

  @Query("SELECT * FROM currencyentity WHERE currencyCode LIKE :code LIMIT 1")
  fun findByCode(code: String): CurrencyEntity

  @Insert
  fun insertAll(users: List<CurrencyEntity>)

  @Delete
  fun delete(user: CurrencyEntity)
}