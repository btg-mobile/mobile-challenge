package com.example.currencyapp.ui.fragment.currencyList

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.repository.ListRepository

class CurrencyListViewModel (private val listRepository: ListRepository) : ViewModel(){
    val error : MutableLiveData<String> = MutableLiveData()
    private val currencyList : MutableLiveData<List<Currency>> = MutableLiveData()

    fun getCurrencyList() : LiveData<List<Currency>> {
        try {
            currencyList.postValue(listRepository.getCurrencyListFromApi().value)
            println("LISTA DA PESTE ${currencyList.value}")
        } catch (e : Exception) {
          error.value = e.message
        }

        return currencyList
    }
}