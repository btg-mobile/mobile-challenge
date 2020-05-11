package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository

class CurrencyViewmodelFactory(
    private val currencyRepository: CurrencyRepository
) :
    ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return CurrencyViewmodel(
            currencyRepository
        ) as T
    }
}