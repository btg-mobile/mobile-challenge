package com.rafao1991.mobilechallenge.moneyexchange.data.local.entity

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.ForeignKey.CASCADE
import com.rafao1991.mobilechallenge.moneyexchange.util.Currency
import com.rafao1991.mobilechallenge.moneyexchange.util.ID
import com.rafao1991.mobilechallenge.moneyexchange.util.SELECTED_CURRENCY
import com.rafao1991.mobilechallenge.moneyexchange.util.TYPE

@Entity(
    tableName = SELECTED_CURRENCY,
    primaryKeys = [ID, TYPE],
    foreignKeys = [ForeignKey(
        entity = CurrencyEntity::class,
        parentColumns = [ID],
        childColumns = [ID],
        onUpdate = CASCADE,
        onDelete = CASCADE
    )]
)
data class SelectedCurrencyEntity(val id: String, val type: Currency, val name: String)