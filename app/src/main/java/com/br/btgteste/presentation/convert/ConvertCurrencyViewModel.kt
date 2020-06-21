package com.br.btgteste.presentation.convert

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.usecase.CurrencyLiveUseCase

class ConvertCurrencyViewModel(val currencyLiveUseCase: CurrencyLiveUseCase): ViewModel() {

    val liveDataResponse: MutableLiveData<ApiResult<Double>> = MutableLiveData()
    val currencyFrom: MutableLiveData<Currency> = MutableLiveData()
    val currencyTo: MutableLiveData<Currency> = MutableLiveData()

    fun convertCurrencyAmount(amount: Double) {

        val currencyFrom = currencyFrom.value
        val currentTo = currencyTo.value

        if (currencyFrom != null && currentTo != null) {
            currencyLiveUseCase(CurrencyLiveUseCase.Params(amount, currencyFrom, currentTo)) {
                liveDataResponse.value = it
            }
        }
    }
}