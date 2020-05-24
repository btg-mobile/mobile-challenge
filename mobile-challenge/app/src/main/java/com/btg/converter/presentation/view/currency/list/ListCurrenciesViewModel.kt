package com.btg.converter.presentation.view.currency.list

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.domain.entity.currency.CurrencyList
import com.btg.converter.domain.interactor.GetCurrencyList
import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.view.currency.CurrencyFilterType

class ListCurrenciesViewModel constructor(
    private val getCurrencyList: GetCurrencyList
) : BaseViewModel() {

    val currencyList: LiveData<List<Currency>> get() = _currencyList
    private val _currencyList by lazy { MutableLiveData<List<Currency>>() }

    var queryFilterType: CurrencyFilterType = CurrencyFilterType.FilterByName
    private var fullCurrencyList: CurrencyList? = null

    init {
        getCurrencyList()
    }

    fun onQueryChanged(query: String) {
        _currencyList.value = fullCurrencyList?.currencies?.filter {
            when (queryFilterType) {
                is CurrencyFilterType.FilterByName -> it.name.contains(query, true)
                is CurrencyFilterType.FilterByCode -> it.code.contains(query, true)
            }
        }
    }

    fun filterFullList(currencyFilterType: CurrencyFilterType) {
        _currencyList.value = fullCurrencyList?.currencies?.sortedBy {
            when (currencyFilterType) {
                is CurrencyFilterType.FilterByName -> it.name
                is CurrencyFilterType.FilterByCode -> it.code
            }
        }
    }

    private fun getCurrencyList() {
        launchDataLoad(onFailure = ::onFailure) {
            fullCurrencyList = getCurrencyList.execute()
            _currencyList.value = fullCurrencyList?.currencies
        }
    }

    private fun onFailure(throwable: Throwable) {
        setDialog(throwable, ::getCurrencyList)
    }
}