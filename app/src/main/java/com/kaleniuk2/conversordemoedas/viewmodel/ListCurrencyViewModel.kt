package com.kaleniuk2.conversordemoedas.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepository
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepositoryImpl

class ListCurrencyViewModel(
    private val repository: CurrencyRepository = CurrencyRepositoryImpl()) : ViewModel() {

    val showLoading: MutableLiveData<Boolean> = MutableLiveData()
    val showError: MutableLiveData<String> = MutableLiveData()
    val showListCurrencies: MutableLiveData<List<Currency>> = MutableLiveData()
    private var listCurrency: List<Currency> = listOf()

    fun interact(interact: Interact) {
        when (interact) {
            is Interact.GetCurrencies -> getCurrencies()
            is Interact.SearchCurrency -> searchCurrency(interact.search)
        }
    }

    private fun searchCurrency(search: String) {
        if (search.isEmpty())
            showListCurrencies.value = listCurrency
        else
        showListCurrencies.value = listCurrency.filter {
            it.abbreviation.toLowerCase().contains(search.toLowerCase())
                    || it.name.toLowerCase().contains(search.toLowerCase())
        }
    }

    private fun getCurrencies() {
        showLoading.value = true
        repository.getListCurrency {
            showLoading.value = false
            when (it) {
                is DataWrapper.Success -> {
                    showListCurrencies.value = it.value
                    listCurrency = it.value
                }
                is DataWrapper.Error -> showError.value = it.error
            }
        }
    }

    sealed class Interact {
        object GetCurrencies : Interact()
        class SearchCurrency(val search: String) : Interact()
    }
}