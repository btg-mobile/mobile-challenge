package com.example.currencyapp.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.currencyapp.database.dao.CurrencyDao
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.network.service.CurrencyList
import com.example.currencyapp.network.service.CurrencyRate
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class HomeRepository(
        private val localData: CurrencyDao,
        private val remoteCurrencyRate: CurrencyRate,
        private val remoteCurrencyList: CurrencyList
) {
    private val scope = CoroutineScope(Job() + Dispatchers.Main)
    private val util = com.example.currencyapp.utils.util()

    suspend fun getExchangeRateValues() : LiveData<List<Currency>> {
       try {
            val list: MutableLiveData<List<Currency>> = MutableLiveData()


                //if (util.isConnected(this@HomeRepository)) {
                //faz um get na api pra atualizar o banco e retorna o banco

                //getCurrencyRemoteResources()

                //}

                list.value = getLocalCurrencies()
            return list
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }

    private suspend fun getLocalCurrencies(): List<Currency> {
        try {
            return localData.getAllCurrencies()
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }


    private suspend fun getCurrencyRemoteResources() {

        try {
            val quotesLiveResponse = remoteCurrencyRate.getCurrencyLive()
            val currencyNameResponse = remoteCurrencyList.getCurrencyList()

            if (quotesLiveResponse.isSuccessful) {
                println("First if ok")
                if (quotesLiveResponse.body()?.success == true && currencyNameResponse.body()?.success == true) {
                    println("Second if ok")
                    val currencyList : MutableList<Currency> = mutableListOf()

                    val quotes = quotesLiveResponse.body()?.quotes
                    val currenciesNameList = currencyNameResponse.body()?.currencies

                    //println("quotes $quotes / namelist $currenciesNameList")

                    val quotesKeys: MutableList<String> = mutableListOf()


                    quotes?.let {
                        quotesKeys.addAll(it.keys.toList())

                        //println("QUOTES KEYS $quotesKeys")

                        for (key in quotesKeys) {
                            val currencyInitials = key.substring(key.length / 2)

                            val currency =
                                    Currency(
                                            currency = currencyInitials,
                                            currencyName = currenciesNameList!![currencyInitials]!!,
                                            rate = it[key]!!)

                            //println("Currency $currency")

                            currencyList.add(currency)
                        }

                        updateLocalDatabase(currencies = currencyList)
                    } ?: throw Exception("Empty List")
                }
            }
        } catch (e: Throwable) {
            println("THROW REMOTE RESOURCES : $e")
        }

    }

    private suspend fun updateLocalDatabase(currencies: List<Currency>) {
        try {
            localData.updateAllRate(currencies)
        } catch (e: Exception) {
            println("THROW update local data : $e")
            throw Exception(e)
        }
    }
}