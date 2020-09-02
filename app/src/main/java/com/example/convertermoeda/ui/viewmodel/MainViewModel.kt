package com.example.convertermoeda.ui.viewmodel

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.convertermoeda.helper.NETWORK_ERROR
import com.example.convertermoeda.provider.providerMainUseCase
import com.example.convertermoeda.ui.viewmodel.base.BaseViewModel
import com.example.convertermoeda.ui.viewmodel.state.MainState
import kotlinx.coroutines.launch

class MainViewModel : BaseViewModel() {
    private val useCase by lazy {
        providerMainUseCase()
    }

    private val state: MutableLiveData<MainState> = MutableLiveData()
    val viewState: LiveData<MainState> = state

    fun buscarLive(context: Context) {
        launch {
            try {
                useCase.buscarLista(context)
            } catch (e: Exception) {
                state.value = MainState.IsErro(NETWORK_ERROR)
            }
        }
    }


    fun getConverter(context: Context, value: Double, origem: String, destino: String) {
        state.postValue(
            MainState.GetCoversao(
                useCase.getCotacaoLocal(context, value, origem, destino)
            )
        )

    }
}