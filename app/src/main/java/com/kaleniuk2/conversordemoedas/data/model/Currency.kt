package com.kaleniuk2.conversordemoedas.data.model

import java.io.Serializable
import java.math.BigDecimal

data class Currency(
    val name: String,
    val abbreviation: String,
    val value: BigDecimal = BigDecimal(0)
) : Serializable {
    override fun toString(): String {
        return name
    }
}