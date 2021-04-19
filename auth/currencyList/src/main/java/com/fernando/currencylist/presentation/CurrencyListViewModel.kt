package com.fernando.currencylist.presentation

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.fernando.currencylist.domain.usecase.CurrencyListUseCase
import com.fernando.currencylist.model.CurrencyViewItem
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CurrencyListViewModel @Inject constructor(
    private val currencyListUseCase: CurrencyListUseCase
) : ViewModel() {

    private val _user = MutableLiveData<List<CurrencyViewItem>>()
    val user: LiveData<List<CurrencyViewItem>>
        get() = _user

    private fun getCurrency() = viewModelScope.launch {
        currencyListUseCase.getCurrency().let {
            it.body()?.let { arroz ->
                if (arroz.success) {
                    _user.value = arroz.currencies.map {
                        CurrencyViewItem(it.key, it.value)
                    }.also {
                        it.sortedBy { it.countryName }
                    }
                }
            }
        }
    }

    private fun getCurrencyFiltered(currency: String) {
        viewModelScope.launch {
            currencyListUseCase.getCurrency().let {
                it.body()?.let { arroz ->
                    if (arroz.success) {
                        _user.value = arroz.currencies.map {
                            CurrencyViewItem(it.key, it.value)
                        }.filter { it.countryName.toLowerCase().contains(currency.toLowerCase()) }
                            .also {
                                it.sortedBy { it.countryName }
                            }
                    }
                }
            }
        }
    }

    fun searchCurrency(currency: String) {
        if (currency.isEmpty()) {
            getCurrency()
        } else {
            getCurrencyFiltered(currency)
        }
    }

    init {
        getCurrency()
    }
}