package com.gft.presentation.viewmodel

import androidx.lifecycle.MutableLiveData
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.usecases.Convert
import com.gft.domain.usecases.GetAllLabels
import com.gft.presentation.entities.Data
import com.gft.presentation.entities.Error
import com.gft.presentation.entities.Status

class CurrencyViewModel(private val getAllLabels: GetAllLabels, private val convert: Convert) :
    BaseViewModel() {

    private var labels = MutableLiveData<Data<CurrencyLabelList>>()

    fun getLabels() {
        val disposable = getAllLabels.getLabels().subscribe(
            { response ->
                labels.value = Data(responseType = Status.SUCCESSFUL, data = response)
            }, { error ->
                labels.value = Data(responseType = Status.ERROR, error = Error(error.message))
            }, {

            }
        )

        addDisposable(disposable)
    }

    fun getLabelsLiveData() = labels
}