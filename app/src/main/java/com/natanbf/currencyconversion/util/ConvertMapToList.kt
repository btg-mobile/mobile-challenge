package com.natanbf.currencyconversion.util

fun <T, R>Map<T, R>.convertMapToList(): List<String> =
    this.toList().map { "${it.first} - ${it.second}" }
