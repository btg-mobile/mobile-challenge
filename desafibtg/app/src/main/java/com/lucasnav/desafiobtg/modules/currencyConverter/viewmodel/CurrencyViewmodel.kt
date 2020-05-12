package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency

class CurrencyViewmodel(
    private val currencyInteractor: CurrencyInteractor
) : ViewModel() {

    var currencies: MutableLiveData<List<Currency>> = MutableLiveData()
    var onLoadFinished = SingleLiveEvent<Void>()
    var onError = SingleLiveEvent<String>()

    fun getCurrencies() {

        currencyInteractor.getCurrencies(
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
