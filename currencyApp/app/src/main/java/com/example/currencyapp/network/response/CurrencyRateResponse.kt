package com.example.currencyapp.network.response;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.Map;

class CurrencyRateResponse {
    @SerializedName("success")
    var success : Boolean ?= null
    @SerializedName("quotes")
    @Expose
    var quotes : MutableMap<String, Double> ?= null
}
