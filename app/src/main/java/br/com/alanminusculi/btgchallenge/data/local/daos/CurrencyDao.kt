package br.com.alanminusculi.btgchallenge.data.local.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Transaction
import br.com.alanminusculi.btgchallenge.data.local.models.Currency

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

@Dao
abstract class CurrencyDao {

    @Query("SELECT * FROM currency ORDER BY name")
    abstract fun findAll(): List<Currency>

    @Query("SELECT * FROM currency WHERE acronym LIKE :query OR name LIKE :query || '%' ORDER BY name")
    abstract fun find(query: String): List<Currency>

    @Query("SELECT * FROM currency WHERE acronym LIKE :query OR name LIKE :query || '%' ORDER BY name LIMIT 1")
    abstract fun findOne(query: String?): Currency

    @Transaction
    open fun replaceAll(vararg items: Currency) {
        deleteAll()
        insertAll(*items)
    }

    @Query("DELETE FROM currency")
    abstract fun deleteAll()

    @Insert
    abstract fun insertAll(vararg currencies: Currency)

    @Query("SELECT * FROM currency WHERE id = :id LIMIT 1")
    abstract fun findById(id: Int): Currency
}