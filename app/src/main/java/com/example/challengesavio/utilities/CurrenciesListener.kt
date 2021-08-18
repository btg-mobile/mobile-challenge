package com.example.challengesavio.utilities

import com.example.challengesavio.api.models.CurrenciesOutputs

interface CurrenciesListener {

    fun onCurrenciesResult(currencies: Map<String, String>)
    fun onQuotesResult(quotes: HashMap<String, Double>)
}