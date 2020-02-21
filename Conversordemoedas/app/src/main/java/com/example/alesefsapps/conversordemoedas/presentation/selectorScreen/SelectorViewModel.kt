package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import android.util.Log
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.ApiService
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyRepository
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal

class SelectorViewModel(private val dataSource: CurrencyRepository) : ViewModel() {

    val selectorLiveData: MutableLiveData<List<Values>> = MutableLiveData()
    val viewFlipperLiveData: MutableLiveData<Pair<Int, Int?>> = MutableLiveData()


    fun getValueLive() {
        dataSource.getValueLive { result: LiveValueResult ->
            when(result) {
                is LiveValueResult.Success -> {
                    getCurrency()
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

    private fun getCurrency() {
        dataSource.getCurrency { result: CurrencyResult ->
            when(result) {
                is CurrencyResult.Success -> {
                    selectorLiveData.value = result.values
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

    companion object {
        private const val VIEW_FLIPPER_CURRENCY_LIST = 1
        private const val VIEW_FLIPPER_ERROR = 2
    }


    class ViewModelFactory(val dataSource: CurrencyRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(SelectorViewModel::class.java)) {
                return SelectorViewModel(dataSource) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }

}