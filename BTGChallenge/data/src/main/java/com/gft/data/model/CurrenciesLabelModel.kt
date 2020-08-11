package com.gft.data.model

import com.gft.domain.entities.CurrencyLabel

data class CurrenciesLabelModel (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: List<CurrencyLabel>
)
