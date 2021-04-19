package com.fernando.currencylist.model

data class CurrencyList(
    val currencies: HashMap<String, String>,
    val success: Boolean
)