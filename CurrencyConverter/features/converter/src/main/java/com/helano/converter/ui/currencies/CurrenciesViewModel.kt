package com.helano.converter.ui.currencies

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.repository.CurrencyRepository
import com.helano.shared.model.Currency
import kotlinx.coroutines.launch

class CurrenciesViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository
): ViewModel() {

    val items by lazy { MutableLiveData<List<Currency>>() }
    val selectedCurrency by lazy { MutableLiveData<String>() }

    fun start() {
        viewModelScope.launch {
            items.value = repository.currencies()
        }
    }

    fun onCurrencySelected(code: String) {
        selectedCurrency.value = code
    }
}