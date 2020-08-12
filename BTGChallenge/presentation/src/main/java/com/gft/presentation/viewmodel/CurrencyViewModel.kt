package com.gft.presentation.viewmodel

import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.usecases.Convert
import com.gft.domain.usecases.GetAllLabels
import com.gft.presentation.entities.ConvertEntity
import com.gft.presentation.entities.Data
import com.gft.presentation.entities.Error
import com.gft.presentation.entities.Status

class CurrencyViewModel(private val getAllLabels: GetAllLabels, private val convert: Convert) :
    BaseViewModel() {

    var data = MutableLiveData<ConvertEntity>()
    private var convertEntity: ConvertEntity =
        ConvertEntity(from = "USD", to = "BRL", fromValue = 0.0, toValue = 0.0)

    init {
        data.value = convertEntity;
    }

    fun setFrom(from: String) {
        convertEntity.from = from
        data.value = convertEntity
    }

    fun setTo(to: String) {
        convertEntity.to = to
        data.value = convertEntity
    }
}