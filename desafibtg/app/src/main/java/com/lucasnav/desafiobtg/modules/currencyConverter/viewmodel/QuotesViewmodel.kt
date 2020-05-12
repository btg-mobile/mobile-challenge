package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor

const val I_HAVE_FOCUSED = 0
const val I_WANT_FOCUSED = 1

class QuotesViewmodel(
    private val currencyInteractor: CurrencyInteractor
) : ViewModel() {

    var amount: MutableLiveData<String> = MutableLiveData()

    var currentFocused = I_HAVE_FOCUSED

    var onLoadFinished = SingleLiveEvent<Void>()
    var onError = SingleLiveEvent<String>()

    init {
        currencyInteractor.getAllQuotesFromApiAndSave()
    }

    fun getQuotesAndCalculateAmount(
        amount: String,
        firstCurrency: String,
        secondCurrency: String
    ) {
        currencyInteractor.getQuotesAndCalculateAmount(
            amount,
            firstCurrency,
            secondCurrency,
            onSuccess = {
                this.amount.value = it.toString()
            },
            onError = {
                onError.value = it
            }
        )
    }
}
