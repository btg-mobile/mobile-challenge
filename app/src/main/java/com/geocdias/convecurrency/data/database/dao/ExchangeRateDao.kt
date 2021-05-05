package com.geocdias.convecurrency.data.database.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity

@Dao
interface ExchangeRateDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertExchangeRateList(rates: List<ExchangeRateEntity>)

    @Query("SELECT * FROM exchange_rate")
    fun observeCurrencyList(): LiveData<List<ExchangeRateEntity>>

    @Query("SELECT * FROM exchange_rate WHERE fromCurrency = :fromCurrency AND toCurrency = :toCurrency")
    fun getRate(fromCurrency: String, toCurrency: String): LiveData<ExchangeRateEntity>

}
