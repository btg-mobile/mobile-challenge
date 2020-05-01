package com.example.mobile_challenge.ui.main

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mobile_challenge.App
import com.example.mobile_challenge.R
import com.example.mobile_challenge.model.Currency
import com.example.mobile_challenge.model.ErrorResponse
import com.example.mobile_challenge.model.ListResponse
import com.example.mobile_challenge.model.LiveResponse
import com.example.mobile_challenge.utility.ClientApi
import com.example.mobile_challenge.utility.SingleLiveData
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json

@OptIn(UnstableDefault::class)
class MainViewModel(
  private val context: Context = App.instance.applicationContext,
  private var client: ClientApi = App.clientApi,
  private var quotes: Map<String, Double> = mapOf("" to 0.0),
  var currencyList: ArrayList<Currency> = arrayListOf()
) : ViewModel() {

  // Handle Error
  val error: SingleLiveData<String> = SingleLiveData()

  // Live currency value
  private val _liveValue: MutableLiveData<Double> = MutableLiveData()
  val liveValue: LiveData<Double> = _liveValue

  // Update "FROM" button
  private val _fromCode: MutableLiveData<String> = MutableLiveData()
  val fromCode: LiveData<String> = _fromCode

  // Update "TO" button
  private val _toCode: MutableLiveData<String> = MutableLiveData()
  val toCode: LiveData<String> = _toCode

  private var currencyFrom = 1.0
  private var currencyTo = 1.0

  init {
    getLiveList()
    getCurrencyList()
  }

  private fun getLiveList() {
    viewModelScope.launch(Dispatchers.Default) {
      try {
        while (true) {
          val json = client.httpRequestGetLive()
          val live = Json.parse(
            LiveResponse.serializer(),
            json
          )
          if (live.success && live.quotes.isNotEmpty()) {
            // Update Quotes
            quotes = live.quotes
            // Update first screen
            getCurrencyValue(
              context.getString(R.string.brl),
              context.getString(R.string.to)
            )
          } else {
            error.postValue(
              context.getString(R.string.fetch_data_error)
            )
          }
          // Get fresh data every 30 seconds
          delay(1000 * 30)
        }
      } catch (e: Exception) {
        handleErrorResponse("live")
      }
    }
  }

  private fun getCurrencyList() {
    viewModelScope.launch {
      try {
        while (true) {
          val json = client.httpRequestGetList()
          val list = Json.parse(
            ListResponse.serializer(),
            json
          )
          if (list.success && list.currencies.isNotEmpty()) {
            // Update Currency List
            getCurrencyList(list)
          } else {
            error.postValue(
              context.getString(R.string.fetch_data_error)
            )
          }
          // Get fresh data every 30 seconds
          delay(1000 * 30)
        }
      } catch (e: Exception) {
        handleErrorResponse("list")
      }
    }
  }

  // Check if it is a error response or a connection problem
  private suspend fun handleErrorResponse(request: String) {
    try { // Error Response
      val json = if (request == "list") {
        client.httpRequestGetList()
      } else {
        client.httpRequestGetLive()
      }
      val list = Json.parse(
        ErrorResponse.serializer(),
        json
      )
      error.postValue(list.error.info)
    } catch (e: Exception) { // Connection Problem
      error.postValue(
        context.getString(R.string.connection_error)
      )
    }
  }

  fun getCurrencyValue(code: String, type: String) {
    val value = quotes.getValue("USD$code")
    if (type == context.getString(R.string.from)) {
      currencyFrom = if (code != context.getString(R.string.usd)) {
        1 / value
      } else {
        value
      }
      _fromCode.postValue(code)
    } else {
      currencyTo = value
      _toCode.postValue(code)
    }
    _liveValue.postValue(currencyFrom * currencyTo)
  }

  private fun getCurrencyList(list: ListResponse) {
    val currenciesMap = list.currencies
    val currenciesList = arrayListOf<Currency>()
    currenciesMap.forEach { entry ->
      val currency = Currency(entry.key, entry.value)
      currenciesList.add(currency)
    }
    currencyList = currenciesList
  }

}

