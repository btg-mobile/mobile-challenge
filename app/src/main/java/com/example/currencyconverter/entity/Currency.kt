package com.example.currencyconverter.entity

import android.os.Parcelable
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize

@Parcelize
@Entity
data class Currency constructor(
    @PrimaryKey
    val symbol: String,
    val name: String,
    var quote: Double): Parcelable