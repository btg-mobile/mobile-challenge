package com.rafao1991.mobilechallenge.moneyexchange.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.rafao1991.mobilechallenge.moneyexchange.util.QUOTE

@Entity(tableName = QUOTE)
data class QuoteEntity(@PrimaryKey val id: String, val quote: Double)
