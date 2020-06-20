package com.example.currencyconverter.infrastructure

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.room.*
import com.example.currencyconverter.entity.Currency

@Dao
interface CurrencyDao{
    @Query("select * from currency")
    fun getCurrencies() : LiveData<List<Currency>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(vararg currency: Currency)
}

@Database(entities = [Currency::class], version = 1)
abstract class CurrenciesDB:RoomDatabase(){
    abstract val currencyDao: CurrencyDao
}

private lateinit var DB: CurrenciesDB

fun getDatabase(context: Context): CurrenciesDB{
    synchronized(CurrenciesDB::class.java){
        if(!::DB.isInitialized){
            DB = Room.databaseBuilder(context.applicationContext,
                CurrenciesDB::class.java,"currencies").build()
        }
    }
    return DB
}