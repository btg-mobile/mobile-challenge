package com.helano.converter.ui.converter

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.converter.model.Currency
import com.helano.repository.CurrencyRepository
import kotlinx.coroutines.launch

class ConverterViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository
) : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "100,00"
    }
    val text: LiveData<String> = _text

    val currencies by lazy { MutableLiveData<List<Currency>>() }

    fun start() {
        viewModelScope.launch {
            repository.currencies()
        }
    }
}