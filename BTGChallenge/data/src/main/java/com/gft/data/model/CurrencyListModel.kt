package com.gft.data.model

data class CurrencyListModel (
    var success: Boolean,
    var terms: String,
    var privacy: String,
    var currencies: List<CurrencyLabelModel>
)
