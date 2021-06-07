package br.com.vicentec12.mobilechallengebtg.data.source.local.dao

import android.database.sqlite.SQLiteDatabase
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.QuoteEntity

@Dao
interface QuoteDao {

    @Insert(onConflict = SQLiteDatabase.CONFLICT_REPLACE)
    suspend fun insert(mQuoteList: List<QuoteEntity>)

    @Query("SELECT * FROM quote")
    suspend fun list(): List<QuoteEntity>

}