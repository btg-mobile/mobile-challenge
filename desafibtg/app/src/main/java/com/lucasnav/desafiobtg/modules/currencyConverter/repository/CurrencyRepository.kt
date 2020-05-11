package com.lucasnav.desafiobtg.modules.currencyConverter.repository

import com.lucasnav.desafiobtg.modules.currencyConverter.networking.CurrencyNetworking

open class CurrencyRepository(
) {
    fun getCurrencies(
        onSuccess: (movies: Map<String, String>) -> Unit,
        onError: (error: String) -> Unit
    ) {

        CurrencyNetworking.getCurrenciesFromApi(
            onSuccess = { currenciesReponse ->
                currenciesReponse?.let { onSuccess(it) }
            },
            onError = { error ->
                onError(error.message.toString())
            }
        )
    }
}