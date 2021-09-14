package com.rafao1991.mobilechallenge.moneyexchange.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.rafao1991.mobilechallenge.moneyexchange.util.CURRENCY

@Entity(tableName = CURRENCY)
data class CurrencyEntity(@PrimaryKey val id: String, val name: String)
