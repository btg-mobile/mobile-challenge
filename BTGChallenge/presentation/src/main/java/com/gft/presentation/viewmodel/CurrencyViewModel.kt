package com.gft.presentation.viewmodel

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.gft.domain.usecases.ConvertUseCase
import com.gft.presentation.entities.ConvertEntity
import io.reactivex.schedulers.Schedulers

class CurrencyViewModel(private val convertUseCase: ConvertUseCase) : ViewModel()
    {

    var data = MutableLiveData<ConvertEntity>()
    var fromValue = MutableLiveData<String>()
    var showProgressBar = MutableLiveData<Boolean>()
    var showToastMessage = MutableLiveData<String>()

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

    fun convert() {
        if (fromValue.value.isNullOrEmpty()) {
            showToastMessage.value = "Digite um valor para começar"
            return
        }
        data.value?.fromValue = fromValue.value?.toDouble()!!
    }
}