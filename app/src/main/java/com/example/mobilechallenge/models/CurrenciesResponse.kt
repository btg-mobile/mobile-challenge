package com.example.mobilechallenge.models

data class CurrenciesResponse(
    var success: Boolean?,
    var terms: String?,
    var privacy: String?,
    var timestamp: Int?,
    var source: String?,
    var quotes: HashMap<String, Float>?
)