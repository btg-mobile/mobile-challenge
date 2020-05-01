package com.example.mobile_challenge.db

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import com.example.mobile_challenge.model.CurrencyEntity
import com.example.mobile_challenge.model.QuoteEntity

@Dao
interface QuoteDao {
  @Query("SELECT * FROM quoteentity")
  fun getAll(): List<QuoteEntity>

  @Query("SELECT * FROM quoteentity WHERE `to` LIKE :code LIMIT 1")
  fun findByCode(code: String): QuoteEntity

  @Insert
  fun insertAll(users: List<QuoteEntity>)

  @Delete
  fun delete(user: QuoteEntity)
}