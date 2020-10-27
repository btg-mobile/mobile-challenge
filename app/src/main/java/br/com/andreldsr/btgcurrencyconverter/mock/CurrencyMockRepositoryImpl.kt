package br.com.andreldsr.btgcurrencyconverter.mock

import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.infra.services.ApiService
import br.com.andreldsr.btgcurrencyconverter.infra.services.CurrencyService
import retrofit2.awaitResponse
import java.lang.Exception

class CurrencyMockRepositoryImpl() : CurrencyRepository {
    override suspend fun getCurrency(): List<Currency> {
        val currencies = mutableListOf<Currency>()

        val currenciesMap = mapOf<String, String>("AED" to "United Arab Emirates Dirham", "CAD" to "Canadian Dollar", "BRL" to "Brazilian Real", "USD" to "United States Dollar")
        currenciesMap.map {
            currencies.add(Currency(initials = it.key, name = it.value))
        }
        return currencies
    }

    override fun searchCurrency(searchTerm: String): List<Currency> {
        return listOf()
    }

    companion object {
        fun build(): CurrencyMockRepositoryImpl {
            return CurrencyMockRepositoryImpl()
        }
    }
}