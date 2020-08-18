package com.kaleniuk2.conversordemoedas.util

import android.util.Log
import java.math.BigDecimal

object NumberUtil {
    fun parseStringToBigDecimal(value: String, decimal: Int = 2): BigDecimal {
        val cleanString = value.replace("R$", "")
            .replace(",","")
            .replace(".","")
            .trim()
        return try {
            val value = BigDecimal(cleanString).setScale(
                decimal, BigDecimal.ROUND_FLOOR
            ).divide(BigDecimal(100), BigDecimal.ROUND_FLOOR)
            value
        } catch (e: NumberFormatException) {
            BigDecimal(0)
        }
    }
}