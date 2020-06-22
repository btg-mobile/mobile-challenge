package com.example.currencyconverter.logic

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.presentation.currencies.CurrencyListView

class CurrenciesInteractor(val view : CurrencyListView) {

    fun onCreate() {

    }

    fun onCurrencySelected(selectedCurrency: Currency) {
        view.finishWithResultingCurrency(selectedCurrency)
    }

    fun onDestroy() {

    }
}