package br.com.vicentec12.mobilechallengebtg.data.source.local

import androidx.room.Database
import androidx.room.RoomDatabase
import br.com.vicentec12.mobilechallengebtg.data.source.local.dao.CurrencyDao
import br.com.vicentec12.mobilechallengebtg.data.source.local.dao.QuoteDao
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.CurrencyEntity
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.QuoteEntity

@Database(entities = [CurrencyEntity::class, QuoteEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {

    abstract fun getCurrencyDao(): CurrencyDao

    abstract fun getQuoteDao(): QuoteDao

    companion object {

        const val DATABASE_NAME = "currencies.db"

    }

}