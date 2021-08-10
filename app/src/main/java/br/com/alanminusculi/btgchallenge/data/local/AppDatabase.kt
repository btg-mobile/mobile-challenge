package br.com.alanminusculi.btgchallenge.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import br.com.alanminusculi.btgchallenge.data.local.daos.CurrencyDao
import br.com.alanminusculi.btgchallenge.data.local.daos.CurrencyValueDao
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

@Database(entities = [Currency::class, CurrencyValue::class], version = 1)
abstract class AppDatabase : RoomDatabase() {

    abstract fun getCurrencyDao(): CurrencyDao
    abstract fun getCurrencyValueDao(): CurrencyValueDao

}