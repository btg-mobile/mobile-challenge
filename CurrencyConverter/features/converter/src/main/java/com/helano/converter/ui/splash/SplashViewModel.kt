package com.helano.converter.ui.splash

import android.util.Log
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.repository.CurrencyRepository
import com.helano.shared.util.Preferences
import com.helano.shared.util.network.ConnectivityStateHolder
import kotlinx.coroutines.launch

class SplashViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository,
    private val prefs: Preferences
) : ViewModel() {

    val dataLoading by lazy { MutableLiveData<Boolean>() }

    init {
        viewModelScope.launch {
            if (ConnectivityStateHolder.isConnected) {
                repository.refreshData()?.let {
                    prefs.lastUpdate = it
                    dataLoading.value = true
                }
            }
        }
    }
}