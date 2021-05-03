package com.leonardo.convertcoins.model

data class SupportedCurrencies(
    val success: Boolean,
    val terms: String,
    val currencies: HashMap<String, String>
)