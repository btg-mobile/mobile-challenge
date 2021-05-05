package com.leonardo.convertcoins.models

data class SupportedCurrencies(
    val success: Boolean,
    val currencies: HashMap<String, String>
)