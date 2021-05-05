package com.geocdias.convecurrency.data.database.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey(autoGenerate = true)
    var id: Int = 0,
    var code: String,
    var name: String
 )
