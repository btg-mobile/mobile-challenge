package com.rafao1991.mobilechallenge.moneyexchange.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty.CurrencyRepository
import com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty.QuoteRepository
import com.rafao1991.mobilechallenge.moneyexchange.domain.Exchange
import com.rafao1991.mobilechallenge.moneyexchange.util.ApiStatus
import com.rafao1991.mobilechallenge.moneyexchange.util.BRL
import com.rafao1991.mobilechallenge.moneyexchange.util.Currency
import com.rafao1991.mobilechallenge.moneyexchange.util.USD
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch

class MainViewModel(
    private val currencyRepository: CurrencyRepository,
    private val quoteRepository: QuoteRepository
) : ViewModel() {

    private var viewModelJob = Job()
    private val coroutineScope = CoroutineScope(viewModelJob + Dispatchers.Main)

    private val _status = MutableLiveData<ApiStatus>()
    val status: LiveData<ApiStatus>
        get() = _status

    private val _currencyList = MutableLiveData<Map<String, String>>()
    val currencyList: LiveData<Map<String, String>>
        get() = _currencyList

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
        _status.value = ApiStatus.LOADING
        _result.value = 0.0
        setStartCurrency()
    }

    fun getData() {
        coroutineScope.launch {
            currencyRepository.getCurrencies()
                .onStart { _status.value = ApiStatus.LOADING }
                .catch { e ->
                    _currencyList.value = HashMap()
                    _status.value = ApiStatus.ERROR
                    e.printStackTrace()
                }.collect {
                    _currencyList.value = it
                    _status.value = ApiStatus.DONE
                }
        }
    }

    private fun setStartCurrency() {
        coroutineScope.launch {
            _originCurrency.value = currencyRepository.getSelectedCurrency(Currency.ORIGIN)
            _targetCurrency.value = currencyRepository.getSelectedCurrency(Currency.TARGET)
        }
    }

    fun setCurrency(currencyType: Currency, item: String) {
        when(currencyType) {
            Currency.ORIGIN -> _originCurrency.value = _currencyList.value?.get(item)
            Currency.TARGET -> _targetCurrency.value = _currencyList.value?.get(item)
        }
        coroutineScope.launch {
            _currencyList.value?.get(item)?.let {
                currencyRepository.setSelectedCurrency(item, currencyType, it)
            }
        }
    }

    private fun getOriginCurrencyKey(): String {
        _currencyList.value?.forEach {
            if (it.value == _originCurrency.value) {
                return it.key
            }
        }

        return USD
    }

    private fun getTargetCurrencyKey(): String {
        _currencyList.value?.forEach {
            if (it.value == _targetCurrency.value) {
                return it.key
            }
        }

        return BRL
    }

    fun handleExchange(amount: String?) {
        if (amount.isNullOrBlank() ||
            _originCurrency.value.isNullOrBlank() ||
            _targetCurrency.value.isNullOrBlank()) {
            _result.value = 0.0
        } else {
            coroutineScope.launch {
                quoteRepository.getQuotes()
                    .catch { e ->
                        _status.value = ApiStatus.ERROR
                        e.printStackTrace()
                    }
                    .collect {
                        _result.value = Exchange(
                            amount.toString().toDouble(),
                            getOriginCurrencyKey(),
                            getTargetCurrencyKey(),
                            it
                        ).getExchanged()
                        _status.value = ApiStatus.DONE
                    }
            }
        }
    }

    fun showLoading() {
        _status.value = ApiStatus.LOADING
    }
}