package com.rafao1991.mobilechallenge.moneyexchange.ui.main

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.rafao1991.mobilechallenge.moneyexchange.data.CurrencyApi
import com.rafao1991.mobilechallenge.moneyexchange.data.CurrencyList
import com.rafao1991.mobilechallenge.moneyexchange.data.CurrencyLiveQuotes
import com.rafao1991.mobilechallenge.moneyexchange.domain.*
import com.rafao1991.mobilechallenge.moneyexchange.domain.Currency
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import retrofit2.await
import java.util.*

class MainViewModel : ViewModel() {

    private var viewModelJob = Job()
    private val coroutineScope = CoroutineScope(viewModelJob + Dispatchers.Main)

    private val _status = MutableLiveData<ApiStatus>()
    val status: LiveData<ApiStatus>
        get() = _status

    private val _currencyList = MutableLiveData<CurrencyList?>()
    val currencyList: LiveData<CurrencyList?>
        get() = _currencyList

    private val _currencyLiveQuotes = MutableLiveData<CurrencyLiveQuotes?>()

    private val _originCurrency = MutableLiveData<String>()
    val originCurrency: LiveData<String>
        get() = _originCurrency

    private val _targetCurrency = MutableLiveData<String>()
    val targetCurrency: LiveData<String>
        get() = _targetCurrency

    private val _result = MutableLiveData<Double>()
    val result: LiveData<Double>
        get() = _result

    init {
        getDataFromApis()
    }

    private fun getDataFromApis() {
        coroutineScope.launch {
            try {
                _status.value = ApiStatus.LOADING
                _currencyList.value = CurrencyApi.service.getList().await()
                _currencyLiveQuotes.value = CurrencyApi.service.getLiveQuotes().await()
                if (validateResponse()) {
                    setStartCurrency()
                    _status.value = ApiStatus.DONE
                } else {
                    _status.value = ApiStatus.ERROR
                }
            } catch (e: Exception) {
                _currencyList.value = CurrencyList(false, mapOf())
                _currencyLiveQuotes.value = CurrencyLiveQuotes(false, mapOf())
                _status.value = ApiStatus.ERROR
            }
        }
    }

    private fun setStartCurrency() {
        _currencyList.value?.let {
            _originCurrency.value = it.currencies[USD]
            _targetCurrency.value = it.currencies[BRL]
        }
    }

    private fun validateResponse(): Boolean {
        return _currencyList.value != null &&
                _currencyList.value!!.success &&
                _currencyLiveQuotes.value != null &&
                _currencyLiveQuotes.value!!.success
    }

    fun setCurrency(currencyType: Currency, item: String) {
        when(currencyType) {
            Currency.ORIGIN -> _originCurrency.value = _currencyList.value?.currencies?.get(item)
            Currency.TARGET -> _targetCurrency.value = _currencyList.value?.currencies?.get(item)
        }
    }

    private fun getOriginCurrencyKey(): String {
        _currencyList.value?.currencies?.forEach {
            if (it.value == _originCurrency.value) {
                return it.key
            }
        }

        return USD
    }

    private fun getTargetCurrencyKey(): String {
        _currencyList.value?.currencies?.forEach {
            if (it.value == _targetCurrency.value) {
                return it.key
            }
        }

        return BRL
    }

    fun handleExchange(amount: String?) {
        if (amount.isNullOrBlank()) {
            _result.value = 0.0
        } else {
            _result.value = Exchange(
                amount.toString().toDouble(),
                getOriginCurrencyKey(),
                getTargetCurrencyKey(),
                _currencyLiveQuotes.value?.quotes!!).getExchanged()
        }
    }
}