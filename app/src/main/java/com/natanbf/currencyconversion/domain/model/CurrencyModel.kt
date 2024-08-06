package com.natanbf.currencyconversion.domain.model

data class CurrencyModel(
    val exchangeRates: Map<String, String> = emptyMap(),
    val currentQuote: Map<String, Double> = emptyMap(),
    val source: String = String(),
    val from: String = String(),
    val to: String = String(),
    val error: String? = null,
)
