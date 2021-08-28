package com.rafao1991.mobilechallenge.moneyexchange.domain

import java.lang.Exception

class Exchange(
    private val amount: Double,
    private val originCurrency: String,
    private val targetCurrency: String,
    private val quotes: Map<String, Double>) {

    fun getExchanged(): Double {
        if (originCurrency == USD || targetCurrency == USD) {
            return exchangeWithUSD(amount)
        }

        return exchange(amount)
    }

    private fun exchange(amount: Double): Double {
        return exchangeFromUSD(exchangeToUSD(amount))
    }

    private fun exchangeWithUSD(amount: Double): Double {
        if (originCurrency == USD) {
            return exchangeFromUSD(amount)
        }

        return exchangeToUSD(amount)
    }

    private fun exchangeToUSD(amount: Double): Double {
        val key = USD + originCurrency

        if (quotes.containsKey(key)) {
            val quote = quotes[key]
            return amount / quote!!
        }

        throw Exception(ERROR)
    }

    private fun exchangeFromUSD(amount: Double): Double {
        val key = USD + targetCurrency

        if (quotes.containsKey(key)) {
            val quote = quotes[key]
            return amount * quote!!
        }

        throw Exception(ERROR)
    }
}