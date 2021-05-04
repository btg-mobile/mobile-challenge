package com.leonardo.convertcoins.models

data class SupportedCurrencies(
    val success: Boolean,
    val terms: String,
    val currencies: HashMap<String, String>
)