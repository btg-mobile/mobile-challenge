package com.gft.presentation.viewmodel

import androidx.lifecycle.MutableLiveData
import com.gft.domain.usecases.ConvertUseCase
import com.gft.presentation.entities.ConvertEntity

class CurrencyViewModel(private val convertUseCase: ConvertUseCase) :
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