package com.example.myapplication.features.coinsconverterlist

import com.google.gson.annotations.SerializedName
import java.io.Serializable

class CoinsConverterListResult : Serializable {
    @SerializedName("success")
    val success: Boolean?=null

    @SerializedName("terms")
    val terms: String?=null

    @SerializedName("privacy")
    val privacy: String?=null

    @SerializedName("currencies")
    val currencies: HashMap<String, String?> = HashMap()
}