package com.kaleniuk2.conversordemoedas.data.remote

import java.sql.Timestamp

data class CurrencyDataResponse(
    val success: Boolean,
    val timestamp: Int,
    val quotes: HashMap<String, String>
)