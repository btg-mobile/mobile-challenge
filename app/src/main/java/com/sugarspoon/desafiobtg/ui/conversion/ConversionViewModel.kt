package com.sugarspoon.desafiobtg.ui.conversion

import android.app.Activity.RESULT_OK
import android.content.Intent
import androidx.lifecycle.*
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.entity.QuotationEntity
import com.sugarspoon.data.local.model.CurrencyModel
import com.sugarspoon.data.local.model.QuotationModel
import com.sugarspoon.data.local.model.toListCurrencyModel
import com.sugarspoon.data.local.model.toListQuotationModel
import com.sugarspoon.data.local.repositories.RepositoryLocal
import com.sugarspoon.data.repositories.ExchangeRateRepository
import com.sugarspoon.desafiobtg.utils.Constants
import com.sugarspoon.desafiobtg.utils.extensions.formatCurrencyBRL
import com.sugarspoon.desafiobtg.utils.extensions.singleSubscribe
import io.reactivex.disposables.CompositeDisposable
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.launch

class ConversionViewModel(
    private val repositoryRemote: ExchangeRateRepository,
    private val repositoryLocal: RepositoryLocal
) : ViewModel() {

    private val compositeDisposable = CompositeDisposable()
    private val allCurrenciesOnDb = repositoryLocal.allCurrencies
    private val allQuotations = repositoryLocal.allQuotations
    private var currencies: List<CurrencyEntity>? = null
    private val _stateLoading = MutableLiveData<Boolean>()

    var stateLoading: LiveData<Boolean> = _stateLoading
    private val _stateOriginText = MutableLiveData<String>()
    var stateOriginText = _stateOriginText
    private val _stateDestinyText = MutableLiveData<String>()
    var stateDestinyText = _stateDestinyText
    private val _amountFinal = MutableLiveData<String>()
    var amountFinal = _amountFinal
    private val _buttonOriginIsVisible = MutableLiveData<Boolean>()
    var buttonOriginIsVisible = _buttonOriginIsVisible
    private val _buttonDestinyIsVisible = MutableLiveData<Boolean>()
    var buttonDestinyIsVisible = _buttonDestinyIsVisible
    private val _displayError = MutableLiveData<String>()
    var displayError = _displayError

    private var changeOptions = ChangeOptions()

    private fun loadCurrencies() {
        if(currencies.isNullOrEmpty()) {
            _stateLoading.value = true
            compositeDisposable.add(repositoryRemote.fetchSupportedCurrencies().singleSubscribe(
                onSuccess = {
                    saveCurrenciesOnDb(it.toListCurrencyModel())
                    _stateLoading.value = false
                },
                onError = {
                    _displayError.value = ERROR_CURRENCIES
                    _stateLoading.value = false
                }
            ))
        }
    }

    private fun loadRealTimeRates() {
        _stateLoading.value = true
        compositeDisposable.add(repositoryRemote.fetchRealTimeRates().singleSubscribe(
            onSuccess = {
                saveQuotationsOnDb(quotations = it.toListQuotationModel())
                _stateLoading.value = false
            },
            onError = {
                _displayError.value = ERROR_QUOTE
                _stateLoading.value = false
            }
        ))
    }

    private fun saveCurrenciesOnDb(
        currencies: List<CurrencyModel> = mutableListOf()
    ) {
        currencies.forEach {
            repositoryLocal.insertCurrency(
                CurrencyEntity(
                    id = 0,
                    code = it.code,
                    name = it.name
                )
            )
        }
    }

    private fun saveQuotationsOnDb(
        quotations: List<QuotationModel> = mutableListOf()
    ) {
        quotations.forEach {
            repositoryLocal.insertQuotation(
                QuotationEntity(
                    id = 0,
                    code = it.code,
                    value = it.value
                )
            )
        }
    }

    fun loadDataOnDb() {
        viewModelScope.launch {
            allCurrenciesOnDb.collect {
                currencies = it
                if(it.isNullOrEmpty()) {
                    loadCurrencies()
                }
            }
        }
        viewModelScope.launch {
            allQuotations.collect {
                if(it.isNullOrEmpty()) {
                    loadRealTimeRates()
                }
            }
        }
    }

    fun updateData() {
        repositoryLocal.deleteQuotation()
        repositoryLocal.deleteCurrency()
        loadDataOnDb()
    }

    fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?) {
        if(resultCode == RESULT_OK) {
            when(requestCode) {
                RESULT_FROM_ORIGIN -> {
                    _stateOriginText.value = data?.getStringExtra(Constants.CODE_EXTRA_INTENT)
                    _stateOriginText.value?.let {
                        changeOptions.origin = repositoryLocal.getQuotationByCode(it)
                        collectOriginCurrency()
                    }
                }
                RESULT_FROM_DESTINY -> {
                    _stateDestinyText.value = data?.getStringExtra(Constants.CODE_EXTRA_INTENT)
                    _stateDestinyText.value?.let {
                        changeOptions.destiny = repositoryLocal.getQuotationByCode(it)
                    }
                }
            }
        }
    }

    fun setValueFromConvert(value: String) {
        _buttonOriginIsVisible.value = value.isNotEmpty()
        changeOptions.valueToConvert = flowOf(
            value.trim().replace(",", ".").toFloat()
        )
    }

    private fun collectOriginCurrency() {
        viewModelScope.launch {
            changeOptions.origin?.collect { quote ->
                quote?.value?.run {
                    changeOptions.run {
                        valueToConvert?.collect { valueToConvert ->
                            (valueToConvert * quote.value) * CORRECTION_FACTOR
                            valueInDollar =
                                flowOf((valueToConvert * quote.value) * CORRECTION_FACTOR)
                            _buttonDestinyIsVisible.value = true
                        }
                    }
                }
            }
        }
    }

    fun convertCurrency() {
        collectOriginCurrency()
        viewModelScope.launch {
            changeOptions.destiny?.collect { quote ->
                quote?.value?.run {
                    changeOptions.run {
                        destiny?.collect { quote ->
                            quote?.value?.run {
                                changeOptions.valueInDollar?.collect { valueInDollar ->
                                    _amountFinal.value = quote.code +
                                            " ${(valueInDollar / quote.value).formatCurrencyBRL(showCurrency = false)}"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    class Factory constructor(
        private val repositoryRemote: ExchangeRateRepository,
        private val repositoryLocal: RepositoryLocal
    ) : ViewModelProvider.NewInstanceFactory() {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            return ConversionViewModel(
                repositoryRemote = repositoryRemote,
                repositoryLocal = repositoryLocal
            ) as T
        }
    }

    companion object {
        private const val RESULT_FROM_ORIGIN = 100
        private const val RESULT_FROM_DESTINY = 200
        private const val CORRECTION_FACTOR = 10
        private const val ERROR_CURRENCIES = "Falha ao carregar os tipos de moedas, tente novamente mais tarde"
        private const val ERROR_QUOTE = "Falha ao carregar as taxas de câmbio, tente novamente mais tarde"
    }

    data class ChangeOptions(
        var origin: Flow<QuotationEntity?>? = null,
        var destiny: Flow<QuotationEntity?>? = null,
        var amount: Flow<Float>? = null,
        var valueToConvert: Flow<Float>? = null,
        var valueInDollar: Flow<Float>? = null,
    )
}
