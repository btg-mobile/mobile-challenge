package com.br.mpc.desafiobtg.utils

import java.text.NumberFormat
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

private val DEFAULT_LOCALE = Locale("pt", "BR")

fun Double.format() =
    NumberFormat.getCurrencyInstance(DEFAULT_LOCALE).format(this).replace("R$", "").trim()

fun Map<String, String>?.transform(): ArrayList<Pair<String, String>> {
    val arrayList = arrayListOf<Pair<String, String>>()
    this?.map { arrayList.add(Pair(it.key, it.value)) }

    return arrayList
}

fun String.toDefaultUpperCase() = this.toUpperCase(DEFAULT_LOCALE)