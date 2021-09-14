package com.rafao1991.mobilechallenge.moneyexchange.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.rafao1991.mobilechallenge.moneyexchange.data.local.entity.SelectedCurrencyEntity
import com.rafao1991.mobilechallenge.moneyexchange.util.Currency

@Dao
interface SelectedCurrencyDAO {

    @Query("SELECT name FROM selected_currency WHERE type = :type")
    suspend fun getSelectedCurrency(type: Currency): String

    @Query("DELETE FROM selected_currency WHERE type = :type")
    suspend fun deleteSelectedCurrency(type: Currency)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(selectedCurrency: SelectedCurrencyEntity)
}