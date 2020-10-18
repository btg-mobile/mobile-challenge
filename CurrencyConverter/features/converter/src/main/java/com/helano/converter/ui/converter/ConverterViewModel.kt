package com.helano.converter.ui.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ConverterViewModel: ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "100,00"
    }
    val text: LiveData<String> = _text
}