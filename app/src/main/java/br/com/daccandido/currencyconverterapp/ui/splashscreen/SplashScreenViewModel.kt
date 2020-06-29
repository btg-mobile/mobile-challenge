package br.com.daccandido.currencyconverterapp.ui.splashscreen

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseViewModel
import kotlinx.coroutines.*

class SplashScreenViewModel(private val currencyData: CurrencyData): BaseViewModel() {

    fun getInfo(complete: (error: Int?, isSuccess: Boolean) -> Unit) {
        CoroutineScope(Dispatchers.Main).launch {
            var isQuote = false
            var isCurrency = false
            var error: Int?

            var isCallQuote = false
            var isCallCurrency = false

            val taskQuote = async { getQuote{ errorQuote, isSuccess ->
                error = errorQuote
                isQuote = isSuccess
                isCallQuote = true

                if (isCallQuote && isCallCurrency) {
                    complete(error, (isQuote && isCurrency))
                }
            } }
            val taskCurrency = async { getCurrency{ errorCurrency, isSuccess ->
                error = errorCurrency
                isCurrency = isSuccess
                isCallCurrency = true

                if (isCallQuote && isCallCurrency) {
                    complete(error, (isQuote && isCurrency))
                }

            } }

            taskQuote.await()
            taskCurrency.await()
        }

    }

    private suspend fun getQuote (complete: (error: Int?, isSuccess: Boolean) -> Unit) {
        currencyData.getAllQuote { result ->
            when (result) {
                is ResultRequest.SuccessQuote -> {
                    complete(null, true)
                }
                is ResultRequest.Error -> {
                    complete(result.error, false)
                }
                is ResultRequest.SeverError -> {
                    complete(R.string.error_not_exchange_rates, false)
                }
            }
        }
    }

    private suspend fun getCurrency (complete: (error: Int?, isSuccess: Boolean) -> Unit) {
        currencyData.getListExchangeRate { result ->
            when (result) {
                is ResultRequest.SuccessExchangeRate -> {
                    complete(null, true)
                }
                is ResultRequest.Error -> {
                    complete(result.error, false)
                }
                is ResultRequest.SeverError -> {
                    complete(R.string.error_not_exchange_rates, false)
                }
            }
        }
    }

    class ViewModelFactory(private val currencyData: CurrencyData) : ViewModelProvider.Factory {
        @Suppress("UNCHECKED_CAST")
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(SplashScreenViewModel::class.java)) {
                return SplashScreenViewModel(currencyData) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }

}