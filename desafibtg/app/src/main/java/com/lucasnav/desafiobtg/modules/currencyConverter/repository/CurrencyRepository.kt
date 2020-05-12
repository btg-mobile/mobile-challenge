package com.lucasnav.desafiobtg.modules.currencyConverter.repository

import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import com.lucasnav.desafiobtg.modules.currencyConverter.networking.CurrencyNetworking

open class CurrencyRepository(
) {
    fun getCurrencies(
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: String) -> Unit
    ) {

        CurrencyNetworking.getCurrenciesFromApi(
            onSuccess = { currenciesReponse ->
                onSuccess(currenciesReponse)
            },
            onError = { error ->
                onError(error.message.toString())
            }
        )
    }

    fun getQuotes(
        fisrtCurrency: String,
        secondCurrency: String,
        onSuccess: (quotes: List<Quote>) -> Unit,
        onError: (error: String) -> Unit
    ) {
        CurrencyNetworking.getQuotesFromApi(
            fisrtCurrency,
            secondCurrency,
            onSuccess = { quotesResponse ->
                onSuccess(quotesResponse)
            },
            onError = { error ->
                onError(error)
            }
        )
    }
}