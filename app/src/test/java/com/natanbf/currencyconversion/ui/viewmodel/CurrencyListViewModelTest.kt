package com.natanbf.currencyconversion.ui.viewmodel

import androidx.lifecycle.SavedStateHandle
import com.natanbf.currencyconversion.domain.model.CurrencyModel
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCase
import com.natanbf.currencyconversion.domain.usecase.SaveCurrencyUseCase
import com.natanbf.currencyconversion.role.MainDispatcherRule
import com.natanbf.currencyconversion.ui.event.CurrencyListEvent
import com.natanbf.currencyconversion.ui.state.CurrencyListState
import com.natanbf.currencyconversion.util.Result
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.kotlin.any
import org.mockito.kotlin.mock
import org.mockito.kotlin.never
import org.mockito.kotlin.verify
import org.mockito.kotlin.whenever
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals

@ExtendWith(MainDispatcherRule::class)
internal class CurrencyListViewModelTest {

    private lateinit var viewModel: CurrencyListViewModel
    private val savedStateHandle: SavedStateHandle = mock()
    private val getExchangeRatesUseCase: GetExchangeRatesUseCase = mock()
    private val saveCurrencyUseCase: SaveCurrencyUseCase = mock()

    @BeforeEach
    fun setUp() {
        viewModel = CurrencyListViewModel(
            savedStateHandle,
            getExchangeRatesUseCase,
            saveCurrencyUseCase
        )
    }

    @Test
    fun initialState_isCorrect() {
        assertEquals(CurrencyListState(), viewModel.initialState)
    }

    @Test
    fun getExchangeRatesUseCase_error_updatesUiState() = runTest {
        val exchangeRates = mapOf("USD" to "United States Dollar", "EUR" to "Euro")
        whenever(getExchangeRatesUseCase()).thenReturn(flow {
            emit(Result.Success(CurrencyModel(exchangeRates = exchangeRates)))
        })

        verify(getExchangeRatesUseCase)()

        assertNotEquals(exchangeRates, viewModel.uiState.value.exchangeRates)
    }

    @Test
    fun sendEvent_SaveCurrency_callsSaveCurrencyUseCase() = runTest {
        val selectedCurrency = "USD"
        whenever(savedStateHandle.get<Boolean>("ARGUMENTS_KEY")).thenReturn(true)
        whenever(saveCurrencyUseCase(selectedCurrency, true)).thenReturn(flow { emit(Unit) })

        viewModel.sendEvent(CurrencyListEvent.SaveCurrency(selectedCurrency))

        verify(saveCurrencyUseCase).invoke(selectedCurrency, true)
    }

    @Test
    fun saveCurrency_noArgument_doesNotCallSaveCurrencyUseCase() = runTest {
        whenever(savedStateHandle.get<Boolean>("ARGUMENTS_KEY")).thenReturn(null)

        viewModel.sendEvent(CurrencyListEvent.SaveCurrency("USD"))

        verify(saveCurrencyUseCase, never()).invoke(any(), any())
    }
}