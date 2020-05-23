package com.btg.converter.domain.entity.quote

data class CurrentQuotes(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Long,
    val sourceCurrencyCode: String,
    val quotes: List<Quote>
)