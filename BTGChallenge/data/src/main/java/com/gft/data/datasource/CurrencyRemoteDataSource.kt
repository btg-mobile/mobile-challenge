package com.gft.data.datasource

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.gft.core.Resource
import com.gft.data.model.CurrenciesLabelModel
import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.entities.CurrencyValue

interface CurrencyRemoteDataSource {
    fun getAllLabels() : MutableLiveData<Resource<CurrenciesLabelModel>>

    fun convert(from: String, to: String, value: Double) : Double
}