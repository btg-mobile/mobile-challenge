package com.example.conversordemoeda.viewmodel

import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.conversordemoeda.model.entidades.Cotacao
import com.example.conversordemoeda.model.repositorio.MoedaRepository
import com.example.conversordemoeda.model.repositorio.STATUS
import com.example.conversordemoeda.model.repositorio.modelResponseCustom.CotacaoResponseCustom
import com.example.conversordemoeda.model.retrofit.CallbackResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainViewModel(private val moedaRepository: MoedaRepository) : ViewModel(), LifecycleObserver {

    val cotacaoData: MutableLiveData<CotacaoResponseCustom> =
        MutableLiveData(CotacaoResponseCustom(status = STATUS.OPEN_LOADING))

    private var cambioDeOrigem: String = "USD"
    private var cambioDeDestino: String = "USD"
    private var cambioPadrao: String = "USD"
    private var valorInformado: Float = 0F

    private var quotes: HashMap<String, Float> = hashMapOf()

    init {
        getListaDeCotacoes()
    }

    private fun getListaDeCotacoes() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                moedaRepository.getContacao(object : CallbackResponse<Cotacao> {
                    override fun success(response: Cotacao) {
                        cambioDeOrigem = response.source
                        cambioDeDestino = response.source
                        cambioPadrao = response.source
                        quotes = response.quotes
                        converterMoeda()
                    }

                    override fun failure(mensagem: String) {
                        cotacaoData.postValue(cotacaoData.value?.apply {
                            errorMessage = mensagem
                            status = STATUS.ERROR
                        })
                    }
                })
            }
        }
    }

    fun definirCambioDeOrigem(cambio: String) {
        cambioDeOrigem = cambio
    }

    fun definirCambioDeDestino(cambio: String) {
        cambioDeDestino = cambio
    }

    fun setValorInformado(valor: Float){
        valorInformado = valor
    }

    fun converterMoeda() {
        if (cambioPadrao == cambioDeOrigem) {
            quotes["$cambioDeOrigem$cambioDeDestino"]?.let { conversaoDeValor(cotacao = it, valor = valorInformado) }
        } else {
            quotes["$cambioPadrao$cambioDeOrigem"]?.let { preConversaoDeValor(cotacao = it, valor = valorInformado) }
        }
    }

    private fun preConversaoDeValor(cotacao: Float, valor: Float) {
        quotes["$cambioPadrao$cambioDeDestino"]?.let { conversaoDeValor(cotacao = it, valor = (valor / cotacao)) }
    }

    private fun conversaoDeValor(cotacao: Float, valor: Float){
        cotacaoData.postValue(cotacaoData.value?.apply {
            valorConvertido = valor * cotacao
            status = STATUS.SUCCESS
        })
    }
}