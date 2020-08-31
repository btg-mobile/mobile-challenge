package com.example.convertermoeda.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.convertermoeda.model.Live
import com.example.convertermoeda.provider.providerUseCase
import com.example.convertermoeda.retrofit.webclient.ResultApi
import com.example.convertermoeda.viewmodel.base.BaseViewModel
import com.example.convertermoeda.viewmodel.state.MainState
import kotlinx.coroutines.launch

class MainViewModel: BaseViewModel() {
    private val useCase by lazy {
        providerUseCase()
    }

    private val state: MutableLiveData<MainState> = MutableLiveData()
    val viewState: LiveData<MainState> = state

    fun buscarLive(){
        launch {
            val resultApi = useCase.buscarLista()
            onResponse(resultApi)
        }
    }

    private fun onResponse(resultApi: ResultApi<Live>) {
        when{
            resultApi.isErro() -> {
                resultApi.erro?.let {
                    state.value = MainState.IsErro(it)
                }
            }
        }
    }
}