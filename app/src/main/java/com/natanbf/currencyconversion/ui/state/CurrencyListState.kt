package com.natanbf.currencyconversion.ui.state

data class CurrencyListState(
    val exchangeRates: Map<String, String> = emptyMap(),
    val goBack: Boolean = false,
    val query: String = String(),
    val active: Boolean = false
)