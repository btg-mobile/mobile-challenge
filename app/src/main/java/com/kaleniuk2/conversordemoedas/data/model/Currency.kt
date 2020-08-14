package com.kaleniuk2.conversordemoedas.data.model

import java.math.BigDecimal

data class Currency(
    val name: String,
    val abbreviation: String,
    val value: Double = 0.0
)