package com.br.btgteste.domain.helper

import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.model.Quote

object QuotesHelper {

    fun convert(amount: Double,from: Currency, to : Currency, quotes:  List<Quote>) : Double{
        val amountInDolars = convertToDolar(amount,from,quotes)
        val quote =  quotes.filter {
            it.code.contentEquals("USD${to.code}")
        }.map { it.value }.firstOrNull() ?: 0.0

        return amountInDolars * quote
    }

    private fun convertToDolar(amount: Double, from: Currency, quotes : List<Quote>) : Double{
        return quotes.filter {it.code.contentEquals("USD${from.code}")}
            .map {
                amount / it.value
            }.firstOrNull() ?: 0.0
    }
}


