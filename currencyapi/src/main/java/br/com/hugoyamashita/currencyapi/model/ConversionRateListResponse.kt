package br.com.hugoyamashita.currencyapi.model

import com.google.gson.annotations.Expose

data class ConversionRateListResponse(

    @Expose
    var success: Boolean,

    @Expose
    var terms: String,

    @Expose
    var privacy: String,

    @Expose
    var timestamp: Long,

    @Expose
    var source: String,

    @Expose
    var quotes: Map<String, Double>

)
