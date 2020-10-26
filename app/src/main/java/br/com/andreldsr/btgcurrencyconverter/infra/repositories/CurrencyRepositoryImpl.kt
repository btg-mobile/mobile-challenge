package br.com.andreldsr.btgcurrencyconverter.infra.repositories

import androidx.lifecycle.MutableLiveData
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.infra.response.CurrencyListResponse
import br.com.andreldsr.btgcurrencyconverter.infra.services.ApiService
import br.com.andreldsr.btgcurrencyconverter.infra.services.CurrencyService
import kotlinx.coroutines.runBlocking
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.awaitResponse
import java.lang.Exception

class CurrencyRepositoryImpl(private val currencyService: CurrencyService) : CurrencyRepository {
    override suspend fun getCurrency(): List<Currency> {
        val currencies = mutableListOf<Currency>()
        val response = currencyService.getCurrency().awaitResponse()
        if(!response.isSuccessful){
            throw Exception()
        }

        val currenciesMap = response.body()?.currencies
        currenciesMap?.map {
            currencies.add(Currency(initials = it.key, name = it.value))
        }
        return currencies
    }

    override fun searchCurrency(searchTerm: String): List<Currency> {
        return listOf()
    }

    companion object {
        fun build(): CurrencyRepositoryImpl {
            return CurrencyRepositoryImpl(ApiService.service)
        }
    }
}