package com.a.coinmaster.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CurrenciesListResponse(
    @SerializedName("currencies")
    val currencies: HashMap<String, String>? = null,
    @SerializedName("privacy")
    val privacy: String? = null,
    @SerializedName("success")
    val success: Boolean? = null,
    @SerializedName("terms")
    val terms: String? = null
) : Parcelable