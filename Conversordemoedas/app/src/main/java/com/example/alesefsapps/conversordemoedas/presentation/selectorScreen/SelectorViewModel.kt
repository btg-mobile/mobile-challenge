package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyRepository
import com.example.alesefsapps.conversordemoedas.data.repository.ValueLiveRepository
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult

class SelectorViewModel(private val valueLiveRepository: ValueLiveRepository, private val currencyRepository: CurrencyRepository) : ViewModel() {

    val selectorLiveData: MutableLiveData<List<Values>> = MutableLiveData()
    val viewFlipperLiveData: MutableLiveData<Pair<Int, Int?>> = MutableLiveData()
    private val values: MutableList<Values> = mutableListOf()

    fun getValueLive() {
        valueLiveRepository.getValueLive { result: LiveValueResult ->
            when(result) {
                is LiveValueResult.Success -> {
                    getCurrency(result.quotes)
                }
                is LiveValueResult.ApiError -> {
                    if (result.statusCode == 401) {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_401_live)
                    } else {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_generico_live)
                    }
                }
                is LiveValueResult.SeverError -> {
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_server_live)
                }
            }
        }
    }

    private fun getCurrency(quotes: List<Quote>) {
        currencyRepository.getCurrency { result: CurrencyResult ->
            when(result) {
                is CurrencyResult.Success -> {
                    getValues(quotes, result.currency)
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_CURRENCY_LIST, null)
                }
                is CurrencyResult.ApiError -> {
                    if (result.statusCode == 401) {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_401_list)
                    } else {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_generico_list)
                    }
                }
                is CurrencyResult.SeverError -> {
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.error_server_list)
                }
            }
        }
    }

    private fun getValues(
        quotes: List<Quote>,
        currency: List<Currency>
    ) {
        currency.forEach { c ->
            quotes.forEach { q ->
                if (q.code.substring(3,6) == c.code) {
                    values.add(Values(c.code, c.name, q.value))
                    values.sortBy { values -> values.name }
                }
            }
        }
        selectorLiveData.value = values
    }

    companion object {
        private const val VIEW_FLIPPER_CURRENCY_LIST = 1
        private const val VIEW_FLIPPER_ERROR = 2
    }


    class ViewModelFactory(private val valueLiveRepository: ValueLiveRepository, private val currencyRepository: CurrencyRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(SelectorViewModel::class.java)) {
                return SelectorViewModel(valueLiveRepository, currencyRepository) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }

}