package com.btg.converter.presentation.view.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.interactor.GetCurrentQuotes
import com.btg.converter.presentation.util.base.BaseViewModel

class ConverterViewModel constructor(
    private val getCurrentQuotes: GetCurrentQuotes
) : BaseViewModel() {

    val currencyQuotes: LiveData<CurrentQuotes> get() = _currencyQuotes
    private val _currencyQuotes by lazy { MutableLiveData<CurrentQuotes>() }

    init {
        getCurrentQuotes()
    }

    fun getCurrentQuotes() {
        launchDataLoad { _currencyQuotes.value = getCurrentQuotes.execute() }
    }
}