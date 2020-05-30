package br.thiagospindola.currencyconverter.domain.models

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Currency(
    val code: String,
    val description: String,
    var quote: Double
):Parcelable