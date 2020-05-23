package com.btg.converter.presentation.di

import com.btg.converter.data.repository.DefaultCurrencyRepository
import com.btg.converter.domain.boundary.CurrencyRepository
import org.koin.dsl.module

fun repositoryModule() = module {
    single {
        DefaultCurrencyRepository(get()) as CurrencyRepository
    }
}