package com.leonardo.convertcoins.models

data class RealtimeRates(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Float,
    val source: String, // USD
    val quotes: Map<String, Double>
)
