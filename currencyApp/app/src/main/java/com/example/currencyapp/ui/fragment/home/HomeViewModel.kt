package com.example.currencyapp.ui.fragment.home

import android.text.Editable
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
    val emptyList : MutableLiveData<Boolean> = MutableLiveData(true)

    val byCurrencyAdapter : MutableLiveData<Int> = MutableLiveData(0)
    val toCurrencyAdapter : MutableLiveData<Int> = MutableLiveData(0)

    val convertedCurrency : MutableLiveData<Double> = MutableLiveData(0.0)

    fun getCurrencies() : LiveData<List<Currency>> {
        try {
            viewModelScope.launch {
                currencies.postValue(homeRepository.getExchangeRateValues().value)
            }
        }catch (e : Exception) {
            error.value = e.message
        }

        emptyList.value =  currencies.value?.isEmpty() ?: true

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

    fun convertCurrencyAtoCurrencyB(text: Editable?): LiveData<Double> {
        if(emptyList.value!!){
            error.value = "Você não pode realizar essa operação"
        } else {
            val currencyAToUSDTaxes = currencies.value?.get(byCurrencyAdapter.value!!)?.rate ?: 1.0
            val currencyUSDToBTaxes = currencies.value?.get(toCurrencyAdapter.value!!)?.rate ?: 1.0

            if(text?.isNotEmpty()!!) {
                val input = text.toString().toDouble()
                val inputInUSD = input.div(currencyAToUSDTaxes) ?: 0.0
                convertedCurrency.value = (inputInUSD * currencyUSDToBTaxes)

            } else error.value = "Escolha um valor"
        }
        return convertedCurrency
    }
}