package com.natanbf.currencyconversion.domain.model

data class ExchangeRatesResponse(
    val success: Boolean = false,
    val currencies: Map<String, String> = mapOf()
)