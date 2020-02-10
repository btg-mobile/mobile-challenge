package com.example.mobilechallenge.models

data class CoinsListResponse(
    var success: Boolean?,
    var terms: String?,
    var privacy: String?,
    var currencies: HashMap<String, String>?
)