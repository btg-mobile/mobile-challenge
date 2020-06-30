package br.com.leonamalmeida.mobilechallenge.ui.main

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Transformations
import androidx.lifecycle.ViewModel
import br.com.leonamalmeida.mobilechallenge.util.CURRENCY_DESTINY_REQUEST
import br.com.leonamalmeida.mobilechallenge.util.CURRENCY_ORIGIN_REQUEST
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.util.SingleLiveEvent
import br.com.leonamalmeida.mobilechallenge.data.repositories.RateRepository

/**
 * Created by Leo Almeida on 29/06/20.
 */

class MainViewModel @ViewModelInject constructor(private val repository: RateRepository) :
    ViewModel() {

    val originCurrency = MutableLiveData<String>()
    val destinyCurrency = MutableLiveData<String>()
    val openCurrencyActivity =
        SingleLiveEvent<Int>()
    val displayAmountField =
        SingleLiveEvent<Boolean>()

    private val convertedValue =
        SingleLiveEvent<Float>()
    private val resultValue = Transformations.switchMap(convertedValue) {
        repository.makeConversion(
            originCurrency.value!!,
            destinyCurrency.value!!,
            it
        )
    }

    val value = MediatorLiveData<Pair<String, Float>>().apply {
        addSource(resultValue) { if (it is Result.Success) value = it.value }
    }

    val loading = MediatorLiveData<Boolean>().apply {
        addSource(resultValue) { if (it is Result.Loading) value = it.isLoading }
    }

    val error = MediatorLiveData<Int>().apply {
        addSource(resultValue) { if (it is Result.Error) value = it.msg }
    }

    fun handleCurrencySelection(requestCode: Int, currencyCode: String?) {
        when (requestCode) {
            CURRENCY_ORIGIN_REQUEST -> originCurrency.value = currencyCode
            CURRENCY_DESTINY_REQUEST -> destinyCurrency.value = currencyCode
        }
        displayAmountField.value =
            (!originCurrency.value.isNullOrBlank() && !destinyCurrency.value.isNullOrBlank())
    }

    fun onOriginClick() {
        openCurrencyActivity.value =
            CURRENCY_ORIGIN_REQUEST
    }

    fun onDestinyClick() {
        openCurrencyActivity.value =
            CURRENCY_DESTINY_REQUEST
    }

    fun convert(amount: String) {
        convertedValue.value = amount.toFloat()
    }
}