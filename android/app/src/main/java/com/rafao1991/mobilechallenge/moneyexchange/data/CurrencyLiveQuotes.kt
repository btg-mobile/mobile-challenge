package com.rafao1991.mobilechallenge.moneyexchange.data

data class CurrencyLiveQuotes(
    val success: Boolean,
    val source: String,
    val quotes: Map<String, Double>
    ) {

    override fun toString(): String {
        var res = ""
        quotes.entries.forEach {
            res += it.key + ": " + it.value + "\n"
        }
        return res
    }
}