package com.natanbf.currencyconversion.ui.viewmodel

import com.natanbf.currencyconversion.domain.model.CurrencyModel
import com.natanbf.currencyconversion.domain.usecase.ConvertedCurrencyUseCase
import com.natanbf.currencyconversion.domain.usecase.GetCurrentQuoteUseCase
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCase
import com.natanbf.currencyconversion.domain.usecase.GetFromToUseCase
import com.natanbf.currencyconversion.role.MainDispatcherRule
import com.natanbf.currencyconversion.ui.event.CurrencyEvent
import com.natanbf.currencyconversion.ui.state.CurrencyState
import com.natanbf.currencyconversion.util.Result
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.Mockito.mock
import org.mockito.kotlin.any
import org.mockito.kotlin.verify
import org.mockito.kotlin.whenever

@ExtendWith(MainDispatcherRule::class)
internal class CurrencyConverterViewModelTest {

    private lateinit var viewModel: CurrencyConverterViewModel
    private val observer = mock<StateFlow<CurrencyState>>()
    private val getExchangeRatesUseCase = mock(GetExchangeRatesUseCase::class.java)
    private val getCurrentQuoteUseCase = mock(GetCurrentQuoteUseCase::class.java)
    private val getFromToUseCase = mock(GetFromToUseCase::class.java)
    private val convertedCurrencyUseCase = mock(ConvertedCurrencyUseCase::class.java)

    @BeforeEach
    fun setup() {
        viewModel = CurrencyConverterViewModel(
            getExchangeRatesUseCase,
            getCurrentQuoteUseCase,
            getFromToUseCase,
            convertedCurrencyUseCase
        )
    }

    @Test
    fun initialStateIsLoading() = runTest {
        verify(observer).onEach { CurrencyState(isLoading = true) }.launchIn(backgroundScope)
    }

    @Test
    fun initialStateIsErrorWhenExchangeRatesFail() = runTest {
        whenever(getExchangeRatesUseCase()).thenReturn(flow { throw Exception("Error") })
        viewModel.sendEvent(CurrencyEvent.Initial)
        verify(observer).onEach { CurrencyState(isLoading = false, isError = "Error") }
            .launchIn(backgroundScope)
    }

    @Test
    fun initialStateIsErrorWhenCurrentQuoteFails() = runTest {
        whenever(getCurrentQuoteUseCase()).thenReturn(flow { throw Exception("Error") })
        viewModel.sendEvent(CurrencyEvent.Initial)
        verify(observer).onEach { (CurrencyState(isLoading = false, isError = "Error")) }
            .launchIn(backgroundScope)
    }

    @Test
    fun initialStateIsErrorWhenFromToFails() = runTest {
        whenever(getFromToUseCase()).thenReturn(flow { throw Exception("Error") })
        viewModel.sendEvent(CurrencyEvent.Initial)
        verify(observer).onEach { (CurrencyState(isLoading = false, isError = "Error")) }
            .launchIn(backgroundScope)
    }

    @Test
    fun initialStateIsSuccessWhenAllUseCasesSucceed() = runTest {
        whenever(getExchangeRatesUseCase()).thenReturn(flow { emit(Result.Success(CurrencyModel())) })
        whenever(getCurrentQuoteUseCase()).thenReturn(flow { emit(Result.Success(CurrencyModel())) })
        whenever(getFromToUseCase()).thenReturn(flow {
            emit(
                Result.Success(
                    CurrencyModel(
                        from = "USD",
                        to = "EUR"
                    )
                )
            )
        })
        viewModel.sendEvent(CurrencyEvent.Initial)
        verify(observer).onEach {
            CurrencyState(
                isLoading = false,
                selectedTextFrom = "USD",
                selectedTextTo = "EUR"
            )
        }.launchIn(backgroundScope)
    }

    @Test
    fun convertedCurrencyUpdatesStateOnSuccess() = runTest {
        val amount = "100"
        val converted = "200"
        whenever(convertedCurrencyUseCase(any(), any(), any())).thenReturn(flow {
            emit(Result.Success(converted))
        })
        viewModel.sendEvent(CurrencyEvent.ConvertedCurrency(amount))
        verify(observer)
            .onEach { CurrencyState(valueFrom = amount, valueTo = converted) }
            .launchIn(backgroundScope)
    }

    @Test
    fun convertedCurrencyUpdatesStateOnError() = runTest {
        val amount = "100"
        whenever(convertedCurrencyUseCase(any(), any(), any())).thenReturn(flow {
            emit(Result.Error("Error"))
        })
        viewModel.sendEvent(CurrencyEvent.ConvertedCurrency(amount))
        verify(observer)
            .onEach { CurrencyState(isLoading = false, isError = "Error") }
            .launchIn(backgroundScope)
    }

    @Test
    fun convertedCurrencyUpdatesStateToEmptyOnEmptyResult() = runTest {
        val amount = "100"
        whenever(convertedCurrencyUseCase(any(), any(), any())).thenReturn(flow {
            emit(Result.Success(""))
        })
        viewModel.sendEvent(CurrencyEvent.ConvertedCurrency(amount))
        verify(observer)
            .onEach { CurrencyState(valueFrom = "", valueTo = "") }
            .launchIn(backgroundScope)
    }

    @Test
    fun convertedCurrencyUpdatesStateToErrorOnException() = runTest {
        val amount = "100"
        whenever(convertedCurrencyUseCase(any(), any(), any())).thenReturn(flow {
            throw Exception("Conversion Error")
        })
        viewModel.sendEvent(CurrencyEvent.ConvertedCurrency(amount))
        verify(observer)
            .onEach { CurrencyState(isLoading = false, isError = "Conversion Error") }
            .launchIn(backgroundScope)
    }

}