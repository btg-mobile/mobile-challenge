package br.com.daccandido.currencyconverterapp.ui.convertcurrency

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.model.QuoteRequest
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ConvertCurresncyViewModel(private val currencyData: CurrencyData): BaseViewModel() {

    val quotes: MutableLiveData<QuoteRequest> = MutableLiveData()

    fun getQuote(currenciyes: String) {
        CoroutineScope(Dispatchers.Main).launch {
            isLoading.value = true
            currencyData.getQuote(currenciyes) { result ->
                when (result) {
                    is ResultRequest.SuccessQuote -> {
                        isLoading.value = false
                        quotes.value = result.quoteRequest
                    }
                    is ResultRequest.Error -> {
                        error.value = result.error
                    }
                    is ResultRequest.SeverError -> {
                        error.value = R.string.error_not_exchange_rates
                    }
                }
            }
        }
    }

    class ViewModelFactory(private val currencyData: CurrencyData) : ViewModelProvider.Factory {
        @Suppress("UNCHECKED_CAST")
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(ConvertCurresncyViewModel::class.java)) {
                return ConvertCurresncyViewModel(currencyData) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}