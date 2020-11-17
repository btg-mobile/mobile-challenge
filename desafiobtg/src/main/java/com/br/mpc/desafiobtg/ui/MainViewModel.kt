package com.br.mpc.desafiobtg.ui

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.br.mpc.desafiobtg.StateViewModel
import com.br.mpc.desafiobtg.model.CurrenciesResponse
import com.br.mpc.desafiobtg.repository.CurrencyLayerAPI
import com.br.mpc.desafiobtg.utils.INPUT_CURRENCY_TYPE
import com.br.mpc.desafiobtg.utils.OUTPUT_CURRENCY_TYPE
import kotlinx.coroutines.launch
import okhttp3.internal.toImmutableMap
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

class MainViewModel : StateViewModel(), KoinComponent {
    private val api: CurrencyLayerAPI by inject()
    var amount: String = "0,00"

    private val _currencies = MutableLiveData<Map<String, String>>()
    val currencies: LiveData<Map<String, String>> get() = _currencies

    private val _inputCurrency = MutableLiveData<String>()
    val inputCurrency: LiveData<String> get() = _inputCurrency

    private val _outputCurrency = MutableLiveData<String>()
    val outputCurrency: LiveData<String> get() = _outputCurrency

    private val _convertedAmount = MutableLiveData<Double>()
    val convertedAmount: LiveData<Double> get() = _convertedAmount

    private val arrayListOfQuotes = ArrayList<Pair<String, Double>>()

    fun fetchCurrencies() {
        viewModelScope.launch {
            if (_currencies.value == null) {
                doRequest(
                    call = { api.getCurrencies() },
                    onSuccess = { response ->
                        val currencies = response.currencies.toSortedMap(compareBy { it }).toMap()
                        _currencies.postValue(currencies)
                    }
                )
            }
        }
    }

    fun convertCurrency(amount: Double) {
        viewModelScope.launch {
            doRequest(
                call = {
                    api.getConverted()
                },
                onSuccess = {
                    val treatedQuotes = it.quotes.toString().removePrefix("{").removeSuffix("}").split(", ")
                    treatedQuotes.forEach { quote ->
                        val splited = quote.split("=")
                        arrayListOfQuotes.add(Pair(splited[0], splited[1].toDouble()))
                    }

                    val a = arrayListOfQuotes.find {
                        it.first.endsWith(inputCurrency.value!!.split(" - ")[0])
                    }!!.second

                    val b = arrayListOfQuotes.find {
                        it.first.endsWith(outputCurrency.value!!.split(" - ")[0])
                    }!!.second

                    _convertedAmount.postValue(amount / a * b)
                }
            )
        }

    }

    fun updateCurrency(currency: Pair<String, String>, type: Int) {
        when (type) {
            INPUT_CURRENCY_TYPE -> _inputCurrency.postValue(currency.first + " - " + currency.second)
            OUTPUT_CURRENCY_TYPE -> _outputCurrency.postValue(currency.first + " - " + currency.second)
        }
    }

    fun changeCurrencies() {
        val input = inputCurrency.value
        val output = outputCurrency.value

        if (input != null && output != null) {
            _inputCurrency.postValue(output)
            _outputCurrency.postValue(input)
        }
    }
}