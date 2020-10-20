package com.helano.database.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "quotes")
data class CurrencyQuote(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val exchange: String,
    val value: Float
)