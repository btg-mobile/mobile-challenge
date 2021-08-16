package com.br.cambio.data.model

import android.os.Parcelable
import androidx.room.Entity
import kotlinx.android.parcel.Parcelize

@Entity
@Parcelize
data class Currency (
    val key: String,
    val value: String
): Parcelable