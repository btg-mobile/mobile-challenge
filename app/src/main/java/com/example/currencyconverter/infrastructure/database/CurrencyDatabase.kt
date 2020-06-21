package com.example.currencyconverter.infrastructure.database

import android.content.Context
import androidx.room.*
import com.example.currencyconverter.entity.Currency

@Database(entities = [Currency::class], version = 1)
abstract class CurrenciesDatabase : RoomDatabase() {
    abstract val currencyDao: CurrencyDao

    companion object {
        @Volatile private var INSTANCE: CurrenciesDatabase? = null

        fun getInstance(context: Context): CurrenciesDatabase =
            INSTANCE ?: synchronized(this) {
                INSTANCE ?: buildDatabase(context).also { INSTANCE = it }
            }

        private fun buildDatabase(context: Context) =
            Room.databaseBuilder(context.applicationContext,
                CurrenciesDatabase::class.java, "Sample.db")
                .build()
    }
}