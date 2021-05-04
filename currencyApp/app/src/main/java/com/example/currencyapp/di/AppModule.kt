package com.example.currencyapp.di

import com.example.currencyapp.network.provideCurrencyListService
import com.example.currencyapp.network.provideCurrencyLiveService
import com.example.currencyapp.network.provideRetrofit
import com.example.currencyapp.repository.ListRepository
import org.koin.dsl.module

val networkModule = module {
    factory { provideCurrencyLiveService(get()) }
    factory { provideCurrencyListService(get()) }
    single { provideRetrofit() }
}

val currencyListModule = module {
    single { ListRepository(get()) }
}
