package com.natanbf.currencyconversion.domain.model

data class CurrentQuoteResponse(
    val success: Boolean? = false,
    val source: String? = String(),
    val quotes: Map<String, Double>? = emptyMap()
)
