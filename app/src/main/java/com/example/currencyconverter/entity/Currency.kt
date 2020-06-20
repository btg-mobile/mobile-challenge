package com.example.currencyconverter.entity

import android.os.Parcelable
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize

@Entity
@Parcelize
data class Currency(
    @PrimaryKey
    val symbol: String,
    val description: String,
    val quoteToUSD: Double): Parcelable