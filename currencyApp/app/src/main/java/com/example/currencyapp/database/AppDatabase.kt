package com.example.currencyapp.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.currencyapp.database.dao.CurrencyDao
import com.example.currencyapp.database.entity.Currency

@Database(entities = [Currency::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao() : CurrencyDao
}