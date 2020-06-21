package com.example.currencyconverter.infrastructure

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.example.currencyconverter.entity.Currency

@Entity
data class DatabaseCurrency constructor(
    @PrimaryKey
    val symbol: String,
    val name: String,
    val quote: Double
)

fun List<DatabaseCurrency>.asDomainCurrency() : List<Currency>{
    return map{
        Currency(
            symbol = it.symbol,
            name = it.name,
            quote = it.quote
        )
    }
}