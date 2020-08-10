package com.a.coinmaster.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.a.coinmaster.model.StateError
import com.a.coinmaster.model.StateLoading
import com.a.coinmaster.model.StateResponse
import com.a.coinmaster.model.StateSuccess
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.usecase.GetCurrenciesListUseCase
import com.a.coinmaster.usecase.GetCurrencyUseCase

class MainViewModel(
    private val currencyUseCase: GetCurrencyUseCase
) : BaseViewModel() {

    val currencyLiveData: LiveData<StateResponse<CurrenciesListVO>>
        get() = _currencyLiveData
    private val _currencyLiveData = MutableLiveData<StateResponse<CurrenciesListVO>>()

    fun getCurrency(coinSelected: String) {
        currencyUseCase
            .execute(coinSelected)
            .doOnSubscribe { _currencyLiveData.postValue(StateLoading()) }
            .subscribe(
                {
                    _currencyLiveData.postValue(StateSuccess(it))
                },
                {
                    _currencyLiveData.postValue(StateError(it))
                }
            )
            .also { disposables.addAll(it) }
    }
}