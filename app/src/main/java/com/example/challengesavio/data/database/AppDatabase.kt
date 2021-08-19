package com.example.roomdatabase.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.challengesavio.data.entity.Currency
import com.example.roomdatabase.dao.CurrencyDao

@Database(version = 1, entities = arrayOf(Currency::class))
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao() : CurrencyDao
}