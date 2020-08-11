package com.gft.data.model

data class CurrencyValueListModel (
    var success: Boolean,
    var terms: String,
    var privacy: String,
    var source: String,
    var quotes: List<CurrencyValueModel>
)
