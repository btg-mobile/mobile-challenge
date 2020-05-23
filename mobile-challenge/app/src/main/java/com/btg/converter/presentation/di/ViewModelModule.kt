package com.btg.converter.presentation.di

import com.btg.converter.presentation.view.converter.ConverterViewModel
import com.btg.converter.presentation.view.currency.list.ListCurrenciesViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

fun viewModelModule() = module {

    viewModel {
        ConverterViewModel(get())
    }

    viewModel {
        ListCurrenciesViewModel(get())
    }
}