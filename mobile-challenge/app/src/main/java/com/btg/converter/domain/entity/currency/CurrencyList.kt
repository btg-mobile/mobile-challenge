package com.btg.converter.domain.entity.currency

data class CurrencyList(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: List<Currency>
)