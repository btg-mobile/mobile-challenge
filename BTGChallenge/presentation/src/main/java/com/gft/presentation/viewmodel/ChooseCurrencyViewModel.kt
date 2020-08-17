package com.gft.presentation.viewmodel

import androidx.lifecycle.*
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.Resource
import com.gft.domain.usecases.GetLabelsUseCase
import com.gft.presentation.entities.Data
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

class ChooseCurrencyViewModel(private val getLabelsUseCase: GetLabelsUseCase) : ViewModel() {

    private var labels: LiveData<Resource<CurrencyLabelList>> =
        liveData(context = viewModelScope.coroutineContext + Dispatchers.IO) {
            emit(getLabelsUseCase.execute())
        }

    fun getLabelsLiveData() = labels
}