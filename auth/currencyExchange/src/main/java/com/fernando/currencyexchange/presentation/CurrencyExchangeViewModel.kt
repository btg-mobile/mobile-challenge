package com.fernando.currencyexchange.presentation

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.fernando.currencyexchange.domain.usecase.CurrencyExchangeUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CurrencyExchangeViewModel @Inject constructor(
    private val currencyExchangeUseCase: CurrencyExchangeUseCase
) : ViewModel() {

    private val exchanges = HashMap<String, String>()

    private val _exchangesSupported = MutableLiveData<List<String>>()
    val exchangesSupported: LiveData<List<String>>
        get() = _exchangesSupported

    private val _currencyExchanged = MutableLiveData<String>()
    val currencyExchanged: LiveData<String>
        get() = _currencyExchanged

    private fun getCurrency() = viewModelScope.launch {
        currencyExchangeUseCase.getCurrency().let {
            it.body()?.let { response ->
                if (response.success) {
                    _exchangesSupported.value = response.quotes.map {
                        it.key
                    }
                    exchanges.putAll(response.quotes)
                }
            }
        }
    }

    fun convert(currencyFrom: String, currencyTo: String, value: String) {
        when {
            currencyFrom == currencyTo -> {
                _currencyExchanged.value = value
            }
            currencyTo != "USDUSD" -> {
                val convertTo = convertToUSDUSD(currencyFrom, value)
                _currencyExchanged.value = convertToCurrency(currencyFrom, convertTo).toString()
            }
            else -> {
                _currencyExchanged.value = convertToUSDUSD(value, currencyFrom).toString()
            }
        }
    }

    private fun convertToCurrency(currencyFrom: String, currencyTo: Double): Double {
        return exchanges.getValue(currencyFrom).toDouble() * currencyTo
    }

    private fun convertToUSDUSD(value: String, currencyFrom: String): Double {
        return exchanges.getValue(currencyFrom).toDouble() * value.toDouble()
    }

    init {
        getCurrency()
    }
}