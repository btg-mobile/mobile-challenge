package br.net.easify.currencydroid.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.net.easify.currencydroid.database.model.Currency

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency ORDER BY currencyId")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(currency: Currency): Long

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(currencyData: List<Currency>)

    @Query("DELETE FROM currency WHERE id = :id")
    fun delete(id: Long)

    @Query("DELETE FROM currency")
    fun deleteAll()
}