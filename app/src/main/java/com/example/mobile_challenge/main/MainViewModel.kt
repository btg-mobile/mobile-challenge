package com.example.mobile_challenge.main

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

  // Handle Quote
  private fun getLiveList() {
    viewModelScope.launch(Dispatchers.Default) {
      try {
        val json = client.httpRequestGetLive()
        val live = Json.parse(QuoteLiveResponse.serializer(), json)
        if (live.success && live.quotes.isNotEmpty()) {
          updateDataBase(live)
          setQuoteValue(context.getString(R.string.brl), context.getString(R.string.to))
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

  private fun updateDataBase(live: QuoteLiveResponse) {
    val list = mutableListOf<QuoteEntity>()
    live.quotes.flatMapTo(list) { entry->
      listOf(
        QuoteEntity(
          UUID.randomUUID().toString(),
          entry.key.substring(0..2),
          entry.key.substring(3..5),
          entry.value
        )
      )
    }
    dataBase.quoteDao().insertAll(list)
    quotes = list
  }

  private fun getQuoteFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val quoteList = dataBase.quoteDao().getAll()
      if (quoteList.isNotEmpty()) {
        quotes = quoteList
        setQuoteValue(context.getString(R.string.brl), context.getString(R.string.to))
      }
    }
  }

  fun setQuoteValue(code: String, type: String) {
    val value = quotes.find { it.to == code }?.value
    value?.let {
      if (type == context.getString(R.string.from)) {
        currencyFrom = 1 / value
        _fromCode.postValue(code)
      } else {
        currencyTo = value
        _toCode.postValue(code)
      }
      _liveValue.postValue(currencyFrom * currencyTo)
    }
  }

  // Handle Currency List
  private fun getCurrencyList() {
    viewModelScope.launch(Dispatchers.Default) {
      try {
        val json = client.httpRequestGetList()
        val listResponse = Json.parse(CurrencyListResponse.serializer(), json)
        if (listResponse.success && listResponse.currencies.isNotEmpty()) {
          setCurrencyFromNetwork(listResponse)
        } else {
          error.postValue(context.getString(R.string.fetch_data_error))
          setCurrencyFromDb()
        }
      } catch (e: Exception) {
        handleErrorResponse("list")
        setCurrencyFromDb()
      }
    }
  }

  private fun setCurrencyFromDb() {
    viewModelScope.launch(Dispatchers.Default) {
      val list = dataBase.currencyDao().getAll()
      if (list.isNotEmpty()) {
        list.flatMapTo(currencyList) { arrayListOf(it) }
      }
    }
  }

  private fun setCurrencyFromNetwork(currencyList: CurrencyListResponse) {
    viewModelScope.launch(Dispatchers.Default) {
      val currenciesMap = currencyList.currencies
      val currenciesList = arrayListOf<CurrencyEntity>()
      currenciesMap.forEach { entry ->
        val currency = CurrencyEntity(
          UUID.randomUUID().toString(),
          entry.key,
          entry.value
        )
        currenciesList.add(currency)
      }
      this@MainViewModel.currencyList = currenciesList
      dataBase.currencyDao().insertAll(currenciesList)
    }
  }

  // Handle Error
  private suspend fun handleErrorResponse(request: String) {
    try {
      // Error Response
      val json = if (request == "list") {
        client.httpRequestGetList()
      } else {
        client.httpRequestGetLive()
      }
      val list = Json.parse(ErrorResponse.serializer(), json)
      error.postValue(list.error.info)
    } catch (e: Exception) {
      // Connection Problem
      error.postValue(
        context.getString(R.string.connection_error)
      )
    }
  }

}

