package com.example.currencyconverter.di

import androidx.room.Room
import com.example.currencyconverter.database.CurrencyDatabase
import com.example.currencyconverter.network.createCurrencyListService
import com.example.currencyconverter.network.createRateService
import com.example.currencyconverter.network.getRetrofit
import org.koin.dsl.module

val networkModule = module {
    factory { createCurrencyListService(get()) }
    factory { createRateService(get()) }
    single { getRetrofit() }
}

val databaseModule = module {
    single { Room.databaseBuilder(get(), CurrencyDatabase::class.java, "currency").build() }
}



