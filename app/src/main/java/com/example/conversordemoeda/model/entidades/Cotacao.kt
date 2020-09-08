package com.example.conversordemoeda.model.entidades

class Cotacao(
    success: Boolean,
    terms: String,
    privacy: String,
    var timestamp:Long,
    var source:String,
    var quotes: HashMap<String, Float>
): BaseResponse(success, terms, privacy)