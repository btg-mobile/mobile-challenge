package br.com.andreldsr.btgcurrencyconverter.domain.usecases

import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import java.lang.Exception

interface SearchCurrency {
    fun searchCurrency(searchTerm: String): List<Currency>
}

class SearchCurrencyImpl(private val currencyRepository: CurrencyRepository): SearchCurrency{
    override fun searchCurrency(searchTerm: String): List<Currency> {
        if(searchTerm.isEmpty())
            throw Exception("Consulta com termo nulo")
        return currencyRepository.searchCurrency(searchTerm)
    }

}