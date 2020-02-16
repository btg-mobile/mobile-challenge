package io.felipeandrade.currencylayertest.ui.currency.conversion

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import io.felipeandrade.domain.CurrencyModel

class CurrencyConversionViewModel(
) : ViewModel() {


    val inputCurrency = MutableLiveData<InputViewState>()
    val outputCurrency = MutableLiveData<OutputViewState>()
    val selectCurrencyCode = MutableLiveData<Int>()


    data class InputViewState(
        val currency: CurrencyModel,
        val value: Double,
        val color: Int
    )

    data class OutputViewState(
        val currency: CurrencyModel,
        val value: Double
    )


    fun inputBtnClicked() {
        selectCurrencyCode.postValue(CurrencyConversionActivity.INPUT_REQ_CODE)
    }

    fun outputBtnClicked() {
        selectCurrencyCode.postValue(CurrencyConversionActivity.OUTPUT_REQ_CODE)
    }

    fun inputValueUpdated(newValue: String) {

    }
}