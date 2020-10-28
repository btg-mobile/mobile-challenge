package br.com.andreldsr.btgcurrencyconverter.domain.repositories

import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency

interface CurrencyRepository {
    suspend fun getCurrency() : List<Currency>
    suspend fun getQuote(from: String, to: String): Float
}