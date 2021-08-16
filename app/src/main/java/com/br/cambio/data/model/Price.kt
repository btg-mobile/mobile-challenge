package com.br.cambio.data.model

import android.os.Parcelable
import androidx.room.Entity
import kotlinx.android.parcel.Parcelize

@Entity
@Parcelize
data class Price (
    val key: String,
    val value: Double
): Parcelable