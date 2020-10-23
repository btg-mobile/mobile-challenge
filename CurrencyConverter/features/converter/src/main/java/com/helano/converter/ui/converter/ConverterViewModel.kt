package com.helano.converter.ui.converter

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.converter.model.ExchangeRates
import com.helano.converter.model.Info
import com.helano.repository.CurrencyRepository
import com.helano.shared.model.Currency
import com.helano.shared.util.Preferences
import kotlinx.coroutines.launch

class ConverterViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository,
    private val prefs: Preferences
) : ViewModel() {

    val fromCurrency by lazy { MutableLiveData<Currency>() }
    val toCurrency by lazy { MutableLiveData<Currency>() }
    val currencyValue by lazy { MutableLiveData<String>() }
    private val exchangeRates = ExchangeRates()

    private val _text = MutableLiveData<String>().apply {
        value = "150,00"
    }
    val text: LiveData<String> = _text

    val currencies by lazy { MutableLiveData<List<Currency>>() }

    fun start() {
        viewModelScope.launch {
            updateCurrencyInfo(prefs.fromCurrencyCode, Info.FROM)
            updateCurrencyInfo(prefs.toCurrencyCode, Info.TO)
        }
    }

    fun updateCurrencyInfo(code: String, info: Info, updatePrefs: Boolean = false) {
        viewModelScope.launch {
            if (info == Info.FROM) {
                fromCurrency.value = repository.getCurrency(code)
                exchangeRates.from = repository.getCurrencyQuote("USD$code").value
                if (updatePrefs)
                    prefs.fromCurrencyCode = code
            } else {
                toCurrency.value = repository.getCurrency(code)
                exchangeRates.to = repository.getCurrencyQuote("USD$code").value
                if (updatePrefs)
                    prefs.toCurrencyCode = code
            }
        }
    }

    fun onValueChanged(value: String) {
        if (value.isNotEmpty() && value != ".") {
            updateView(value.toFloat())
        }
    }

    private fun updateView(value: Float) {
        _text.value = (value * (exchangeRates.to / exchangeRates.from)).toString()
    }
}