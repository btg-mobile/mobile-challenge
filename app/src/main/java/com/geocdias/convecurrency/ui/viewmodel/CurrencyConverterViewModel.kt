package com.geocdias.convecurrency.ui.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.repository.CurrencyRepository
import com.geocdias.convecurrency.util.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CurrencyConverterViewModel @Inject constructor(val repository: CurrencyRepository): ViewModel() {

//    private val _currencyList = MutableLiveData<Resource<List<CurrencyModel>>>()
//    val currencyList: LiveData<Resource<List<CurrencyModel>>> = _currencyList

    val currencyList: LiveData<Resource<List<CurrencyModel>>> = repository.fetchCurrencies()

//    fun fetchCurrencyList() {
//        viewModelScope.launch {
//          val resource = repository.fetchCurrencies()
//            _currencyList.postValue(resource.value)
//        }
//    }

}
