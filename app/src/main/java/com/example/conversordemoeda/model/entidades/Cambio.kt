package com.example.conversordemoeda.model.entidades

class Cambio (
    success: Boolean,
    terms: String,
    privacy: String,
    var currencies: HashMap<String,String>
):BaseResponse(success, terms, privacy)