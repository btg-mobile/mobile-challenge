package com.example.myapplication.features.main

import com.google.gson.annotations.SerializedName
import java.io.Serializable
import java.math.BigDecimal

class CoinsPriceResult: Serializable {

        @SerializedName("success")
        val success: Boolean?=null

        @SerializedName("terms")
        val terms: String?=null

        @SerializedName("privacy")
        val privacy: String?=null

        @SerializedName("timestamp")
        val timestamp: Int?=null

        @SerializedName("source")
        val source: String?=null

        @SerializedName("quotes")
        val quotes: HashMap<String, BigDecimal?> = HashMap()
}