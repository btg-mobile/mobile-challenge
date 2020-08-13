package com.curymorais.moneyconversion.data.remote.model

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class CurrencyListResponse(
    val success: Boolean?,
    val terms: String?,
    val privacy: String?,
    val currencies: HashMap<String, String> = HashMap()
)