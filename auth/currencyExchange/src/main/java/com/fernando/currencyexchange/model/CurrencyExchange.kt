package com.fernando.currencyexchange.model

data class CurrencyExchange(
    val quotes: HashMap<String, String>,
    val success: Boolean
)