package com.btgpactual.currencyconverter.data.framework.retrofit.response

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class QuoteListResponse(
    val success: Boolean,
    val quotes: Map<String, Double>
)