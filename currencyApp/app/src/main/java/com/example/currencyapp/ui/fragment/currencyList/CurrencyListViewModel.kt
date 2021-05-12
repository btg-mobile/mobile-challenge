package com.example.currencyapp.ui.fragment.currencyList

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.repository.ListRepository
import kotlinx.coroutines.launch

class CurrencyListViewModel (private val listRepository: ListRepository) : ViewModel(){
    val error : MutableLiveData<String> = MutableLiveData()
    private val currencyList : MutableLiveData<List<Currency>> = MutableLiveData()

    fun getCurrencyList() : LiveData<List<Currency>> {
        try {
            viewModelScope.launch {
                currencyList.postValue(listRepository.getCurrencyListFromApi().value)
            }
        } catch (e : Exception) {
          error.value = e.message
        }

        return currencyList
    }
}