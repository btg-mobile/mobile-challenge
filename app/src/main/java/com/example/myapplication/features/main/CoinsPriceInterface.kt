package com.example.myapplication.features.main

interface CoinsPriceInterface {
    fun onValidateRequestSuccess(result: CoinsPriceResult)
    fun onValidateRequestFail(message: String?, error: Boolean)
}