package io.felipeandrade.currencylayertest.ui.currency.conversion

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import io.felipeandrade.domain.CurrencyModel

class CurrencyConversionViewModel(
) : ViewModel() {


    val inputCurrency: LiveData<InputViewState> = MutableLiveData()
    val outputCurrency: LiveData<OutputViewState> = MutableLiveData()

    data class InputViewState(
        val currency: CurrencyModel,
        val value: Double,
        val color: Int
    )

    data class OutputViewState(
        val currency: CurrencyModel,
        val value: Double
    )
}