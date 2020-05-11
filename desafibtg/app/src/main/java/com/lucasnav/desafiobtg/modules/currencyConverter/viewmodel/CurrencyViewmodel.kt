package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository

class CurrencyViewmodel(
    private val currencyRepository: CurrencyRepository
) : ViewModel() {

    var currencies: MutableLiveData<Map<String, String>> = MutableLiveData()

    var onLoadFinished = SingleLiveEvent<Void>()

    var onError = SingleLiveEvent<String>()

    fun getCurrencies() {

        currencyRepository.getCurrencies(
            onSuccess = { currencies ->
                this.currencies.value = currencies
                onLoadFinished.call()
            },
            onError = { errorMessage ->
                onError.value = errorMessage
                onError.call()
                onLoadFinished.call()
            }
        )
    }
}
