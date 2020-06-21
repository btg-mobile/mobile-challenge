package com.example.currencyconverter.infrastructure

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.room.*

@Dao
interface CurrencyDao {

    @Query("select * from databasecurrency")
    fun getCurrencies() : LiveData<List<DatabaseCurrency>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(vararg currency: DatabaseCurrency)
}

@Database(entities = [DatabaseCurrency::class], version = 1)
abstract class CurrenciesDB:RoomDatabase(){
    abstract val currencyDao: CurrencyDao
}

private lateinit var DB: CurrenciesDB

fun getDatabase(context: Context): CurrenciesDB {
    synchronized(CurrenciesDB::class.java) {
        if(!::DB.isInitialized) {
            DB = Room.databaseBuilder(context.applicationContext,
                CurrenciesDB::class.java,"currencies").build()
        }
    }
    return DB
}