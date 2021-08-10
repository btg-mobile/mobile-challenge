package br.com.alanminusculi.btgchallenge.data.local.daos

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Transaction
import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

@Dao
abstract class CurrencyValueDao {

    @Query("SELECT * FROM currencyvalue WHERE currency like :query LIMIT 1")
    abstract fun findOneByCurrency(query: String): CurrencyValue

    @Transaction
    open fun replaceAll(vararg items: CurrencyValue) {
        deleteAll()
        insertAll(*items)
    }

    @Query("DELETE FROM currencyvalue")
    abstract fun deleteAll()

    @Insert
    abstract fun insertAll(vararg prices: CurrencyValue)
}