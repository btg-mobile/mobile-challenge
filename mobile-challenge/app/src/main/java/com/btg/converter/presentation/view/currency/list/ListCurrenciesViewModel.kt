package com.btg.converter.presentation.view.currency.list

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btg.converter.domain.entity.currency.CurrencyList
import com.btg.converter.domain.interactor.GetCurrencyList
import com.btg.converter.presentation.util.base.BaseViewModel

class ListCurrenciesViewModel constructor(
    private val getCurrencyList: GetCurrencyList
) : BaseViewModel() {

    val currencyList: LiveData<CurrencyList> get() = _currencyList
    private val _currencyList by lazy { MutableLiveData<CurrencyList>() }

    init {
        getCurrencyList()
    }

    private fun getCurrencyList() {
        launchDataLoad { _currencyList.value = getCurrencyList.execute() }
    }
}