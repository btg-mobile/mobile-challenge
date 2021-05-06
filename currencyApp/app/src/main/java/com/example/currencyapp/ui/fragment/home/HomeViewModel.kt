package com.example.currencyapp.ui.fragment.home

class HomeViewModel {


    fun convertCurrencyAtoCurrencyB(input : Number, currencyAToUSDTaxes : Number, currencyUSDToBTaxes : Number) : Double{
        //val currencyAToUSDTaxes = 5.441196 //taxa de conversao que vem da page
        var inputInUSD : Double = 0.0
        var result : Double = 0.0

        inputInUSD = ((input.toDouble()) / currencyAToUSDTaxes.toDouble())
        result = (inputInUSD * currencyUSDToBTaxes.toDouble())

        return result
    }
}