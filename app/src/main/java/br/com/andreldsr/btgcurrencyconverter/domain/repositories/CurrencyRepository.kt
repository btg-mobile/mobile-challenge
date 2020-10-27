package br.com.andreldsr.btgcurrencyconverter.domain.repositories

import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency

interface CurrencyRepository {
    suspend fun getCurrency() : List<Currency>
    fun searchCurrency(searchTerm: String) : List<Currency>
}