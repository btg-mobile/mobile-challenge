package br.com.hugoyamashita.currencyapi.model

import com.google.gson.annotations.Expose
import retrofit2.http.GET

data class CurrencyListResponse(

    @Expose
    var success: Boolean,

    @Expose
    var terms: String,

    @Expose
    var privacy: String,

    @Expose
    var currencies: Map<String, String>

)