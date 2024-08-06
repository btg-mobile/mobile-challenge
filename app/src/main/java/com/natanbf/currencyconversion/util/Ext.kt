package com.natanbf.currencyconversion.util

import com.google.gson.Gson
import java.math.BigDecimal

internal fun BigDecimal.validationIfIsLessOrEqualZero(): BigDecimal =
    if (this <= BigDecimal.ZERO) BigDecimal.ZERO
    else this

internal fun String.isNumeric() = this.matches("\\d+(\\.\\d+)?".toRegex())

inline fun <reified T : Any> T.json(): String = Gson().toJson(this, T::class.java)
inline fun <reified T : Any> String.fromJson(): T = Gson().fromJson(this, T::class.java)
