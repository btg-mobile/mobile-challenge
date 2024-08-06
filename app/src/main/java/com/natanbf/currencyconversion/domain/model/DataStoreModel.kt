package com.natanbf.currencyconversion.domain.model

data class DataStoreModel(
    val exchangeRates: Map<String, String> = mapOf(),
    val currentQuote: Map<String, Double> = mapOf(),
    val from: String = String(),
    val to: String = String()
)