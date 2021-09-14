package com.rafao1991.mobilechallenge.moneyexchange.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty.CurrencyRepository
import com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty.QuoteRepository
import com.rafao1991.mobilechallenge.moneyexchange.util.UNKNOWN_VIEW_MODEL_CLASS
import java.lang.IllegalArgumentException

class MainViewModelFactory(
    private val currencyRepository: CurrencyRepository,
    private val quoteRepository: QuoteRepository
): ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(MainViewModel::class.java)) {
            return MainViewModel(currencyRepository, quoteRepository) as T
        }
        throw IllegalArgumentException(UNKNOWN_VIEW_MODEL_CLASS)
    }
}