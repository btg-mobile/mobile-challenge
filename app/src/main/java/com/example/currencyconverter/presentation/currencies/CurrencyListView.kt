package com.example.currencyconverter.presentation.currencies

import com.example.currencyconverter.entity.Currency

interface CurrencyListView {
    fun finishWithResultingCurrency(currency: Currency)
}