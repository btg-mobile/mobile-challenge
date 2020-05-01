package com.example.mobile_challenge.ui.main

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mobile_challenge.App
import com.example.mobile_challenge.model.Currency
import com.example.mobile_challenge.utility.ClientApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainViewModel(
  var client: ClientApi = App.clientApi
) : ViewModel() {

  private val _liveInfo: MutableLiveData<Double> = MutableLiveData()
  val liveInfo: LiveData<Double> = _liveInfo

  private val _currencyList: MutableLiveData<ArrayList<Currency>> = MutableLiveData()
  val currencyList: LiveData<ArrayList<Currency>> = _currencyList

  // Update "FROM" button
  private val _fromCode: MutableLiveData<String> = MutableLiveData()
  val fromCode: LiveData<String> = _fromCode

  // Update "TO" button
  private val _toCode: MutableLiveData<String> = MutableLiveData()
  val toCode: LiveData<String> = _toCode

  private var currencyFrom = 1.0
  private var currencyTo = 1.0

  init {
    getLiveList("BRL", "TO")
  }

  fun getLiveList(code: String, type: String) {
    viewModelScope.launch(Dispatchers.Default) {
      val live = client.httpRequestGetLive()
      val value = live.quotes.getValue("USD$code")
      if (type == "FROM") {
        currencyFrom = if (code != "USD") {
          1 / value
        } else {
          value
        }
        // Update FROM button
        _fromCode.postValue(code)
      } else {
        currencyTo = value
        // Update TO button
        _toCode.postValue(code)
      }
      _liveInfo.postValue(currencyFrom * currencyTo)
    }
  }

  fun getCurrencyList() {
    viewModelScope.launch {
      val list = client.httpRequestGetList()
      val currenciesMap = list.currencies
      val currenciesList = arrayListOf<Currency>()
      currenciesMap.forEach { entry ->
        val currency = Currency(entry.key, entry.value)
        currenciesList.add(currency)
      }
      _currencyList.postValue(currenciesList)
    }
  }

}
