package com.example.currencyconverter.database

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey
    var currency: String,
    var rate: Double,
    var currencyName: String
)