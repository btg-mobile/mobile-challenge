package com.example.myapplication.features.coinsconverterlist

interface CoinsConverterInterface {
    fun onValidateRequestSuccess(result: CoinsConverterListResult)
    fun onValidateRequestFail(message: String?, error: Boolean)
}