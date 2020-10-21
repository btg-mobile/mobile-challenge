package com.helano.converter.ui.converter

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
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

    private val _text = MutableLiveData<String>().apply {
        value = "150,00"
    }
    val text: LiveData<String> = _text

    val currencies by lazy { MutableLiveData<List<Currency>>() }

    fun start() {
        viewModelScope.launch {
            repository.currencies()
            fromCurrency.value = repository.getCurrency(prefs.getFromCurrencyCode())
            toCurrency.value = repository.getCurrency(prefs.getToCurrencyCode())
        }
    }
}