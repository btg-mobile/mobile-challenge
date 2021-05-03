package com.leonardo.convertcoins.model

data class Currency (
    val coin: String,
    val description: String
): Comparable<Currency> {

    override fun compareTo(other: Currency): Int {
        return coin.compareTo(other.coin)
    }
}