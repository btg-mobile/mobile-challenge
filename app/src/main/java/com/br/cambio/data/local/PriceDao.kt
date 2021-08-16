package com.br.cambio.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price

@Dao
interface PriceDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertPriceList(price: List<Price>)

    @Query("SELECT * FROM Price")
    suspend fun getPriceList(): List<Price>
}