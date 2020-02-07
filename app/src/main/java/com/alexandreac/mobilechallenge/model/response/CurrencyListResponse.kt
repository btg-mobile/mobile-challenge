package com.alexandreac.mobilechallenge.model.response

data class CurrencyListResponse (var success:Boolean? = false,
                                 var terms:String? = null,
                                 var privacy:String? = null,
                                 var currencies: Map<String, String>? = null)