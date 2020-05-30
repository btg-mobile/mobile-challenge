package br.thiagospindola.currencyconverter.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.Transformations
import br.thiagospindola.currencyconverter.database.CurrenciesDatabase
import br.thiagospindola.currencyconverter.database.asDomainCurrency
import br.thiagospindola.currencyconverter.domain.models.Currency
import br.thiagospindola.currencyconverter.network.Network
import br.thiagospindola.currencyconverter.network.toCurrencyDatabaseList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CurrencyRepository(private val database: CurrenciesDatabase){

    val currencies: LiveData<List<Currency>> = Transformations.map(
        database.currencyDao.getCurrencies()){
        it.asDomainCurrency()
    }

    suspend fun refreshCurrencies(){
        withContext(Dispatchers.IO){
            val currencies = Network.currencyApi.getCurrenciesAsync().await()
            val quotes = Network.currencyApi.getQuotesAsync().await()
            val currenciesWithQuotes = currencies.toCurrencyDatabaseList(quotes)
            database.currencyDao.insertAll(*currenciesWithQuotes)
        }
    }
}