package br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.domain.usecases.ListCurrency
import br.com.andreldsr.btgcurrencyconverter.domain.usecases.ListCurrencyImpl
import kotlinx.coroutines.launch

class CurrencyListViewModel(private val repository: CurrencyRepository) : ViewModel() {
    var currencyLiveData: MutableLiveData<List<Currency>> = MutableLiveData()

    fun getCurrencies() {
        val listCurrency: ListCurrency = ListCurrencyImpl(repository)
        viewModelScope.launch {
            currencyLiveData.value = listCurrency.getList()
        }
    }

    class ViewModelFactory(private val repository: CurrencyRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(CurrencyListViewModel::class.java)) return CurrencyListViewModel(repository) as T
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}