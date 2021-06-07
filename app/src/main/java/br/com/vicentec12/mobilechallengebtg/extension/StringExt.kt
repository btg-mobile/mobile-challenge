package br.com.vicentec12.mobilechallengebtg.extension

fun String.currencyToDouble() = trim().replace(".", "")
    .replace(",", ".").toDoubleOrNull()