package com.example.currencyapp.ui.fragment.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.repository.HomeRepository
import kotlinx.coroutines.launch

class HomeViewModel(private val homeRepository: HomeRepository) : ViewModel() {
    private val currencies : MutableLiveData<List<Currency>> = MutableLiveData()
    private val currencyInitials : MutableLiveData<List<String>> = MutableLiveData()
    val error : MutableLiveData<String> = MutableLiveData()
    val convertedCurrency : MutableLiveData<Double> = MutableLiveData(0.0)

    fun getCurrencies() : LiveData<List<Currency>> {
        try {
            viewModelScope.launch {
                currencies.postValue(homeRepository.getExchangeRateValues().value)
            }
        }catch (e : Exception) {
            error.value = e.message
        }
        return currencies
    }

    fun getCurrenciesInitials() : LiveData<List<String>> {
        val initialsList = mutableListOf<String>()
        currencies.value?.forEach {
            initialsList.add(it.currency)
        }

        currencyInitials.postValue(initialsList)
        return currencyInitials
    }

    fun convertCurrencyAtoCurrencyB(input : Number, currencyAToUSDTaxes : Number, currencyUSDToBTaxes : Number) : Double {
        //val currencyAToUSDTaxes = 5.441196 //taxa de conversao que vem da page
        var inputInUSD : Double = 0.0
        var result : Double = 0.0

        inputInUSD = ((input.toDouble()) / currencyAToUSDTaxes.toDouble())
        result = (inputInUSD * currencyUSDToBTaxes.toDouble())

        return result
    }
}