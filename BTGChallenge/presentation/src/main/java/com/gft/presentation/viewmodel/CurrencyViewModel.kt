package com.gft.presentation.viewmodel

import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.gft.domain.usecases.ConvertUseCase
import com.gft.presentation.entities.ConvertEntity
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class CurrencyViewModel(private val convertUseCase: ConvertUseCase) :
    BaseViewModel() {

    var data = MutableLiveData<ConvertEntity>()
    var fromValue = MutableLiveData<String>()
    var showProgressBar = MutableLiveData<Boolean>()

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
        data.value?.fromValue = fromValue.value?.toDouble()!!

        val disposable = convertUseCase.execute(
            from = data.value!!.from,
            to = data.value!!.to,
            value = data.value!!.fromValue
        ).subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread()).doOnSubscribe {
                showProgressBar.value = true
            }
            .subscribe(
                { response ->
                    showProgressBar.value = false
                    convertEntity.toValue = response
                    data.value = convertEntity
                },
                { error ->
                    showProgressBar.value = false
                    Log.i("ERROR", "$error")
                }
            )

        addDisposable(disposable)
    }
}