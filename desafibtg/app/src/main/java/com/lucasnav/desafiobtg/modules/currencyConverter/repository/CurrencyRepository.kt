package com.lucasnav.desafiobtg.modules.currencyConverter.repository

import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.networking.CurrencyNetworking

open class CurrencyRepository(
) {
    fun getCurrencies(
        onSuccess: (movies: List<Currency>) -> Unit,
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
}