package com.example.convertermoeda.ui.viewmodel

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.convertermoeda.helper.NETWORK_ERROR
import com.example.convertermoeda.model.Currencies
import com.example.convertermoeda.provider.providerListaMoedasUseCase
import com.example.convertermoeda.ui.viewmodel.base.BaseViewModel
import com.example.convertermoeda.ui.viewmodel.state.ListaMoedasInteracao
import com.example.convertermoeda.ui.viewmodel.state.ListaMoedasState
import kotlinx.coroutines.launch

class ListaMoedasViewModel : BaseViewModel() {
    private val useCase by lazy {
        providerListaMoedasUseCase()
    }
    private val state: MutableLiveData<ListaMoedasState> = MutableLiveData()
    val viewState: LiveData<ListaMoedasState> = state

    private lateinit var listMoedas: List<Currencies>

    fun getListaMoedas(context: Context) {
        state.value = ListaMoedasState.ShowLoading
        launch {
            try {
                val resultApi = useCase.getListaMoedas(context)
                state.value = ListaMoedasState.ShowListsMoedas(resultApi)
                resultApi?.let { setLocalLista(it) }
            } catch (e: Exception) {
                state.value = ListaMoedasState.IsErro(NETWORK_ERROR)
            }

            state.value = ListaMoedasState.HideLoading
        }
    }

    fun getLocalListaMoedas(context: Context) {
        state.value = ListaMoedasState.ShowLoading
        launch {
            val resultApi = useCase.getLocal(context)
            try {
                state.value = resultApi?.let { ListaMoedasState.ShowListsMoedas(it) }
                resultApi?.let { setLocalLista(it) }
            } catch (e: Exception) {
                state.value = ListaMoedasState.IsErro(NETWORK_ERROR)
            }
            state.value = ListaMoedasState.HideLoading
        }
    }

    private fun setLocalLista(list: List<Currencies>) {
        listMoedas = list
    }

    fun getList() = listMoedas

    fun interactor(itemClicado: ListaMoedasInteracao) {
        when (itemClicado) {
            is ListaMoedasInteracao.ItemClicado -> {
                state.value = ListaMoedasState.MoedaEscolihda(itemClicado.item)
            }
        }
    }
}