package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor

class QuotesViewmodelFactory(
    private val currencyInteractor: CurrencyInteractor
) :
    ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return QuotesViewmodel(
            currencyInteractor
        ) as T
    }
}