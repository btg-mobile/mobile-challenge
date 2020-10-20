package com.helano.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.helano.database.dao.CurrencyDao
import com.helano.database.dao.CurrencyQuoteDao
import com.helano.database.entities.Currency
import com.helano.database.entities.CurrencyQuote

@Database(
    entities = [Currency::class, CurrencyQuote::class],
    exportSchema = false,
    version = 1
)
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao

    abstract fun currencyQuoteDao(): CurrencyQuoteDao
}