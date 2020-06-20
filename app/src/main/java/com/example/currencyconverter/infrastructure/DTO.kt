package com.example.currencyconverter.infrastructure

import com.example.currencyconverter.entity.Currency
import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class CurrencyDTO(
    @Json(name = "success")
    val result: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String,String>
)

@JsonClass(generateAdapter = true)
data class QuotesDTO(
    @Json(name = "success")
    val result: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Long,
    val source: String,
    val quotes: Map<String,Double>
)

fun CurrencyDTO.toCurrencyList(quotes:QuotesDTO):List<Currency>{
    return currencies.toList().map{
        Currency(
            symbol = it.first,
            description = it.second,
            quoteToUSD = quotes.quotes.getValue("USD"+it.first)
        )
    }
}

fun CurrencyDTO.toCurrencyDatabaseList(quotes:QuotesDTO):Array<Currency>{
    return currencies.toList().map{
        Currency(
            symbol = it.first,
            description = it.second,
            quoteToUSD = quotes.quotes.getValue("USD"+it.first)
        )
    }.toTypedArray()
}