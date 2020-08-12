package com.gft.presentation.viewmodel

import androidx.lifecycle.MutableLiveData
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.usecases.GetLabelsUseCase
import com.gft.presentation.entities.Data
import com.gft.presentation.entities.Error
import com.gft.presentation.entities.Status
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class ChooseCurrencyViewModel(private val getLabelsUseCase: GetLabelsUseCase) :
    BaseViewModel() {

    private var labels = MutableLiveData<Data<CurrencyLabelList>>()

    fun getLabels() {
        val disposable = getLabelsUseCase.getLabels().subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(
                { response ->
                    labels.value = Data(responseType = Status.SUCCESSFUL, data = response)
                },
                { error ->
                    labels.value = Data(
                        responseType = Status.ERROR,
                        error = Error("Não foi possível realizar a operação")
                    )
                }
            )

        addDisposable(disposable)
    }

    fun getLabelsLiveData() = labels
}