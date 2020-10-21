package com.helano.converter.ui.currencies

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.repository.CurrencyRepository
import com.helano.shared.model.Currency
import kotlinx.coroutines.launch

class CurrenciesViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository
): ViewModel() {

    private val _items = MutableLiveData<List<Currency>>()
    val items: LiveData<List<Currency>> = _items

    fun start() {
        viewModelScope.launch {
            _items.value = repository.currencies()
        }
    }
}