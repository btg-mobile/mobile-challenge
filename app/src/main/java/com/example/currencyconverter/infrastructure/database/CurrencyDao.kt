package com.example.currencyconverter.infrastructure.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.currencyconverter.entity.Currency
import io.reactivex.Completable
import io.reactivex.Flowable

@Dao
interface CurrencyDao {

    @Query("SELECT * FROM currency")
    fun getCurrency() : Flowable<List<Currency>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertCurrency(currency: Currency): Completable
}