package com.br.cambio.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price

@Database(entities = [Currency::class, Price::class], version = 1, exportSchema = true)
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao

    abstract fun priceDao(): PriceDao
}