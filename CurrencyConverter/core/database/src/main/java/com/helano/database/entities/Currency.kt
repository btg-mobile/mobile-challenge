package com.helano.database.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currencies")
class Currency(
    @PrimaryKey(autoGenerate = true)
    val id: Long,
    val currencyCode: String,
    val currencyName: String
)