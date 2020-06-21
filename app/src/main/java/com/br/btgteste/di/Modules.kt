package com.br.btgteste.di

import com.br.btgteste.data.remote.RetrofitConfiguration
import com.br.btgteste.data.repositories.CurrenciesRepositoryImpl
import com.br.btgteste.domain.repository.CurrenciesRepository
import com.br.btgteste.domain.usecase.CurrencyListUseCase
import com.br.btgteste.domain.usecase.CurrencyLiveUseCase
import com.br.btgteste.presentation.convert.ConvertCurrencyViewModel
import com.br.btgteste.presentation.list.ListCurrencyViewModel
import org.koin.android.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module

val listModules = listOf(
    module {

        single { RetrofitConfiguration().getAppRequest() }

        factory<CurrenciesRepository> { CurrenciesRepositoryImpl(get()) }

        single { CurrencyListUseCase(get()) }
        single { CurrencyLiveUseCase(get()) }

        viewModel { ConvertCurrencyViewModel(get()) }
        viewModel { ListCurrencyViewModel(get()) }
    }
)