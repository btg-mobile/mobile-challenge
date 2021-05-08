package com.example.currencyapp.ui.fragment.home

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.repository.HomeRepository

class HomeViewModel(private val homeRepository: HomeRepository) : ViewModel() {
    val currencies : MutableLiveData<List<Currency>> = MutableLiveData()
    private val error : MutableLiveData<String> = MutableLiveData()

    fun getCurrencies() {
        try {
            currencies.value = homeRepository.getExchangeRateValues().value
        }catch (e : Exception) {
            error.value = e.message
        }
    }

    fun convertCurrencyAtoCurrencyB(input : Number, currencyAToUSDTaxes : Number, currencyUSDToBTaxes : Number) : Double{
        //val currencyAToUSDTaxes = 5.441196 //taxa de conversao que vem da page
        var inputInUSD : Double = 0.0
        var result : Double = 0.0

        inputInUSD = ((input.toDouble()) / currencyAToUSDTaxes.toDouble())
        result = (inputInUSD * currencyUSDToBTaxes.toDouble())

        return result
    }
}