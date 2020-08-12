package com.gft.data.model

data class CurrencyLabelListModel (
    var success: Boolean,
    var terms: String,
    var privacy: String,
    var currencies: Map<String, String>
)
