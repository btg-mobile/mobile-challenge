package com.example.challengesavio.utilities

import com.example.challengesavio.api.models.CurrenciesOutputs

interface CurrenciesListener {

    fun onCurrenciesError(message: String)
    fun onQuotesError(message: String)
}