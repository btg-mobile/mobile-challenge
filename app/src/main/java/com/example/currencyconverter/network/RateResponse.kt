package com.example.currencyconverter.network

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class RateResponse {

    @SerializedName("success")
    var success: Boolean? = null

    @SerializedName("quotes")
    @Expose
    var rates: MutableMap<String, Double>? = null

}