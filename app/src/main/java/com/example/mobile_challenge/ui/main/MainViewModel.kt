package com.example.mobile_challenge.ui.main

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mobile_challenge.App
import com.example.mobile_challenge.R
import com.example.mobile_challenge.db.AppDatabase
import com.example.mobile_challenge.model.*
import com.example.mobile_challenge.utility.ClientApi
import com.example.mobile_challenge.utility.SingleLiveData
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json
import java.util.*
import kotlin.collections.ArrayList

@OptIn(UnstableDefault::class)
class MainViewModel(
  private val context: Context = App.instance.applicationContext,
  private var client: ClientApi = App.clientApi,
  private val dataBase: AppDatabase = App.db,
  private var quotes: List<QuoteEntity> = arrayListOf(),
  var currencyList: ArrayList<CurrencyEntity> = arrayListOf()
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
        val json = client.httpRequestGetLive()
        val live = Json.parse(LiveResponse.serializer(), json)
        if (live.success && live.quotes.isNotEmpty()) {
          val list = mutableListOf<QuoteEntity>()
          live.quotes.flatMapTo(list) {
            listOf(
              QuoteEntity(
                UUID.randomUUID().toString(),
                it.key.substring(0..2),
                it.key.substring(3..5),
                it.value
              )
            )
          }
          dataBase.quoteDao().insertAll(list)
          quotes = list
          getQuoteValue(context.getString(R.string.brl), context.getString(R.string.to))
        } else {
          error.postValue(context.getString(R.string.fetch_data_error))
          getQuoteFromDb()
        }
      } catch (e: Exception) {
        handleErrorResponse("live")
        getQuoteFromDb()
      }
    }
  }

  private fun getQuoteFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val quoteList = dataBase.quoteDao().getAll()
      if (quoteList.isNotEmpty()) {
        quotes = quoteList
        getQuoteValue(context.getString(R.string.brl), context.getString(R.string.to))
      }
    }
  }

  fun getQuoteValue(code: String, type: String) {
    val value = quotes.find { it.to == code }?.value
    value?.let {
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
  }

  private fun getCurrencyList() {
    viewModelScope.launch(Dispatchers.Default) {
      try {
        val json = client.httpRequestGetList()
        val listResponse = Json.parse(ListResponse.serializer(), json)
        if (listResponse.success && listResponse.currencies.isNotEmpty()) {
          getCurrencyList(listResponse)
        } else {
          error.postValue(context.getString(R.string.fetch_data_error))
          getCurrencyFromDb()
        }
      } catch (e: Exception) {
        handleErrorResponse("list")
        getCurrencyFromDb()
      }
    }
  }

  private fun getCurrencyFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val list = dataBase.currencyDao().getAll()
      if (list.isNotEmpty()) {
        list.flatMapTo(currencyList) { arrayListOf(it) }
      }
    }
  }

  private fun getCurrencyList(list: ListResponse) {
    viewModelScope.launch(Dispatchers.Default) {
      val currenciesMap = list.currencies
      val currenciesList = arrayListOf<CurrencyEntity>()
      currenciesMap.forEach { entry ->
        val currency = CurrencyEntity(
          UUID.randomUUID().toString(),
          entry.key,
          entry.value
        )
        currenciesList.add(currency)
      }
      currencyList = currenciesList
      dataBase.currencyDao().insertAll(currenciesList)
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

}

