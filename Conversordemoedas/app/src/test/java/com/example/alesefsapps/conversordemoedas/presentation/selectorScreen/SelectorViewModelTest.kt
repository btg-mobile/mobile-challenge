package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.core.executor.testing.InstantTaskExecutorRule
import android.arch.lifecycle.Observer
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyRepository
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult
import com.nhaarman.mockitokotlin2.verify
import org.junit.Assert.*
import org.junit.Rule
import org.junit.Test
import org.mockito.Mock
import java.math.BigDecimal


class SelectorViewModelTest {
/*
    @get:Rule
    val rule = InstantTaskExecutorRule()

    private lateinit var viewModel: SelectorViewModel

    @Mock
    private lateinit var liveValueResult: LiveValueResult

    @Mock
    private lateinit var selectorLiveDataObserver: Observer<List<Values>>

    @Mock
    private lateinit var viewFlipperLiveDataObserver: Observer<Pair<Int, Int?>>


    @Test
    fun `when view model getValueLive get success then sets getCurrency`() {
        val value = listOf(
            Values("AAA", "name AAA", BigDecimal.valueOf(1))
        )

        val resultSuccess = MockRepository(CurrencyResult.Success(value), liveValueResult)
        viewModel = SelectorViewModel(resultSuccess)
        viewModel.selectorLiveData.observeForever(selectorLiveDataObserver)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        viewModel.getValueLive()

        verify(selectorLiveDataObserver).onChanged(value)
        verify(viewFlipperLiveDataObserver).onChanged(Pair(1, null))
    }
}


class MockRepository(private val currencyResult: CurrencyResult, val liveValueResult: LiveValueResult
) : CurrencyRepository {
    override fun getValueLive(valueResultCallback: (result: LiveValueResult) -> Unit) {
        valueResultCallback(liveValueResult)
    }

    override fun getCurrency(currenciesResultCallback: (result: CurrencyResult) -> Unit) {
        currenciesResultCallback(currencyResult)
    }
*/
}