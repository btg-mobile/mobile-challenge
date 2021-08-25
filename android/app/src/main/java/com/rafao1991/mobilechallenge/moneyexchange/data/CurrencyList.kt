package com.rafao1991.mobilechallenge.moneyexchange.data

data class CurrencyList(val success: Boolean, val currencies: Map<String, String>) {
    override fun toString(): String {
        var res = ""
        currencies.entries.forEach {
            res += it.key + ": " + it.value + "\n"
        }
        return res
    }
}