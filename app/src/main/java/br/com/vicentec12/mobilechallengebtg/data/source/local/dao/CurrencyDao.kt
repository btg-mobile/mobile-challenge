package br.com.vicentec12.mobilechallengebtg.data.source.local.dao

import android.database.sqlite.SQLiteDatabase
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.CurrencyEntity

@Dao
interface CurrencyDao {

    @Insert(onConflict = SQLiteDatabase.CONFLICT_REPLACE)
    suspend fun insert(mCurrencies: List<CurrencyEntity>)

    @Query("SELECT * FROM currency")
    suspend fun list(): List<CurrencyEntity>

}