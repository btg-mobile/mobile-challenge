package com.rafao1991.mobilechallenge.moneyexchange.ui.main

import android.util.Log
import androidx.lifecycle.ViewModel
import com.rafao1991.mobilechallenge.moneyexchange.data.CurrencyApi
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class MainViewModel : ViewModel() {
    private var viewModelJob = Job()
    private val coroutineScope = CoroutineScope(viewModelJob + Dispatchers.IO)

    init {
        getDataFromApis()
    }

    @Suppress("BlockingMethodInNonBlockingContext")
    private fun getDataFromApis() {
        coroutineScope.launch {
            try {
                CurrencyApi.service.getList().execute().body()
                CurrencyApi.service.getLiveQuotes().execute().body()
            } catch (e: Exception) {
                Log.e(javaClass.name, e.message, e)
            }
        }
    }
}