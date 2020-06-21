package com.example.currencyconverter.infrastructure

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.Transformations
import com.example.currencyconverter.entity.Currency
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CurrencyRepository(private val database: CurrenciesDB) {

    private val compositeDisposable = CompositeDisposable()

    val currencies: LiveData<List<Currency>> = Transformations.map(
        database.currencyDao.getCurrencies()){
        it.asDomainCurrency()
    }

    suspend fun refreshCurrencies() {
        withContext(Dispatchers.IO) {

//            val currencies = RetrofitClient.currencyApi.getCurrencyList()
//            Log.i("TAG", currencies.toString())
//            val quotes = RetrofitClient.currencyApi.getLiveQuotes()
//            //al currenciesWithQuotes = currencies.toCurrencyDatabaseList(quotes)
//            database.currencyDao.insertAll(*currenciesWithQuotes)
//            Log.i("Currencies saved to DB", currenciesWithQuotes.toString())
        }
    }
}