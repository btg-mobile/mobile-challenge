package br.com.hugoyamashita.currencyapi.model

import com.google.gson.annotations.Expose

open class BaseResponseModel(

    @Expose
    open var success: Boolean,

    @Expose
    open var terms: String,

    @Expose
    open var privacy: String

)