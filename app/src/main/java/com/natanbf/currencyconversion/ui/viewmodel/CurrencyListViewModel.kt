package com.natanbf.currencyconversion.ui.viewmodel

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.viewModelScope
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCase
import com.natanbf.currencyconversion.domain.usecase.SaveCurrencyUseCase
import com.natanbf.currencyconversion.navigation.ARGUMENTS_KEY
import com.natanbf.currencyconversion.ui.event.CurrencyListEvent
import com.natanbf.currencyconversion.ui.state.CurrencyListState
import com.natanbf.currencyconversion.util.BaseViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onCompletion
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CurrencyListViewModel @Inject constructor(
    private val savedStateHandle: SavedStateHandle,
    private val getExchangeRatesUseCase: GetExchangeRatesUseCase,
    private val saveCurrencyUseCase: SaveCurrencyUseCase,
) : BaseViewModel<CurrencyListState, CurrencyListEvent>() {

    private val _query = MutableStateFlow("")
    private val _filteredExchangeRates = MutableStateFlow(emptyMap<String, String>())
    val filteredExchangeRates: StateFlow<Map<String, String>> get() = _filteredExchangeRates.asStateFlow()
    val query: StateFlow<String> get() = _query.asStateFlow()

    override val initialState: CurrencyListState
        get() = CurrencyListState()

    init {
        _query
            .debounce(200)
            .distinctUntilChanged()
            .combine(
                getExchangeRatesUseCase()
            ) { query, exchangeRates ->
                exchangeRates.onSuccess { updateUiState { copy(exchangeRates = it.exchangeRates) } }
                if (query.isBlank()) {
                    currentState.exchangeRates
                } else {
                    currentState.exchangeRates.filter {
                        it.key.contains(query, ignoreCase = true) || it.value.contains(
                            query,
                            ignoreCase = true
                        )
                    }
                }
            }

            .onEach {
                _filteredExchangeRates.value = it
            }
            .launchIn(viewModelScope)
    }

    override fun handleEvent(event: CurrencyListEvent) {
        when (event) {
            is CurrencyListEvent.SaveCurrency -> saveCurrency(event.selected)
            is CurrencyListEvent.UpdateQuery -> updateQuery(event.query)
            is CurrencyListEvent.SetActive -> updateUiState { copy(active = event.active) }
            CurrencyListEvent.OnNavigation -> updateUiState { copy(goBack = true) }
        }
    }

    private fun updateQuery(newQuery: String) {
        _query.value = newQuery
    }

    private fun saveCurrency(item: String) {
        viewModelScope.launch {
            savedStateHandle.get<Boolean>(ARGUMENTS_KEY)?.apply {
                saveCurrencyUseCase(item, this)
                    .onCompletion {
                        handleEvent(event = CurrencyListEvent.OnNavigation)
                    }.collect()
            }
        }
    }
}
