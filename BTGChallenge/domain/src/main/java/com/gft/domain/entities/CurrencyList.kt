package com.gft.domain.entities

data class CurrencyList(
    val success: Boolean? = null,
    val terms: String? = null,
    val privacy: String? = null,
    val currencies: List<CurrencyLabel> = emptyList()
)