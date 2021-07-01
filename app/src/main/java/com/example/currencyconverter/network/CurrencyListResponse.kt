package com.example.currencyconverter.network

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class CurrencyListResponse {
    @SerializedName("success")
    var success: Boolean? = null

    @SerializedName("currencies")
    @Expose
    var currencies: MutableMap<String, String>? = null
}