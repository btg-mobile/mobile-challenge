package com.kaleniuk2.conversordemoedas.viewmodel

import androidx.lifecycle.ViewModel
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepository
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepositoryImpl

class HomeViewModel(val repository: CurrencyRepository = CurrencyRepositoryImpl()) : ViewModel() {

}