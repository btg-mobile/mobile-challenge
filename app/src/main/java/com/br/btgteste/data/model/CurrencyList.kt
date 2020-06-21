package com.br.btgteste.data.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CurrencyList(
    val success : Boolean,
    val terms : String?,
    val privacy : String?,
    val currencies : CurrencyPayload,
    val error : ErrorPayload?
): Parcelable