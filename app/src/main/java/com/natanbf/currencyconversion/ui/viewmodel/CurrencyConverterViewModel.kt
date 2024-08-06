package com.natanbf.currencyconversion.ui.viewmodel

import androidx.lifecycle.viewModelScope
import com.natanbf.currencyconversion.domain.usecase.ConvertedCurrencyUseCase
import com.natanbf.currencyconversion.domain.usecase.GetCurrentQuoteUseCase
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCase
import com.natanbf.currencyconversion.domain.usecase.GetFromToUseCase
import com.natanbf.currencyconversion.ui.event.CurrencyEvent
import com.natanbf.currencyconversion.ui.state.CurrencyState
import com.natanbf.currencyconversion.util.BaseViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onCompletion
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

@HiltViewModel
class CurrencyConverterViewModel @Inject constructor(
    private val getExchangeRatesUseCase: GetExchangeRatesUseCase,
    private val getCurrentQuoteUseCase: GetCurrentQuoteUseCase,
    private val getFromToUseCase: GetFromToUseCase,
    private val convertedCurrencyUseCase: ConvertedCurrencyUseCase
) : BaseViewModel<CurrencyState, CurrencyEvent>() {
    override val initialState: CurrencyState
        get() = CurrencyState()

    init {
        initial()
    }

    private fun initial() {
        combine(
            getExchangeRatesUseCase(),
            getCurrentQuoteUseCase(),
            getFromToUseCase()
        ) { getExchangeRates, getCurrentQuote, getFromTo ->

            getExchangeRates
                .onLoading { updateUiState { copy(isLoading = true) } }
                .onError { message, _ ->
                    updateUiState { copy(isLoading = false, isError = message) }
                }

            getCurrentQuote
                .onError { message, _ ->
                    updateUiState { copy(isLoading = false, isError = message) }
                }

            getFromTo
                .onSuccess { model ->
                    updateUiState {
                        copy(
                            isLoading = false,
                            selectedTextFrom = model.from,
                            selectedTextTo = model.to
                        )
                    }
                }
                .onError { message, _ ->
                    updateUiState { copy(isLoading = false, isError = message) }
                }

        }
            .catch {
                updateUiState { copy(isLoading = false, isError = it.message) }
            }
            .onCompletion { updateUiState { copy(isLoading = false) } }
            .launchIn(viewModelScope)
    }

    override fun handleEvent(event: CurrencyEvent) {
        when (event) {
            is CurrencyEvent.Initial -> initial()
            is CurrencyEvent.ConvertedCurrency -> {
                event.amount?.let {
                    convertedCurrency(
                        amount = it
                    )
                }
            }
        }
    }

    @OptIn(FlowPreview::class)
    private fun convertedCurrency(amount: String) {
        convertedCurrencyUseCase(
            amount,
            currentState.selectedTextFrom,
            currentState.selectedTextTo
        )
            .onEach { result ->
                result
                    .onSuccess { converted ->
                        updateUiState {
                            copy(
                                valueFrom = if (converted.isNotEmpty()) amount else String(),
                                valueTo = converted
                            )
                        }
                    }
            }
            .debounce(100)
            .distinctUntilChanged()
            .catch {
                updateUiState { copy(isLoading = false, isError = it.message) }
            }
            .launchIn(viewModelScope)

    }
}
