package br.com.daccandido.currencyconverterapp.ui.listcurrency

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.model.ExchangeRate
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ListCurrentViewModel(private val currencyData: CurrencyData): BaseViewModel() {

    val listCurrency: MutableLiveData<ExchangeRate> = MutableLiveData()

    fun getList() {
        CoroutineScope(Dispatchers.Main).launch {
            isLoading.value = true
            currencyData.getListExchangeRate { result ->
                when (result) {
                    is ResultRequest.SuccessExchangeRate -> {
                        isLoading.value = false
                        listCurrency.value = result.exchangeRate
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
            if (modelClass.isAssignableFrom(ListCurrentViewModel::class.java)) {
                return ListCurrentViewModel(currencyData) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}