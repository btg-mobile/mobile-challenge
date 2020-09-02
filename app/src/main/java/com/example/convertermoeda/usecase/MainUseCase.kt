package com.example.convertermoeda.usecase

import android.content.Context
import com.example.convertermoeda.helper.NETWORK_ERROR
import com.example.convertermoeda.helper.USD
import com.example.convertermoeda.model.Live
import com.example.convertermoeda.model.Quotes
import com.example.convertermoeda.repository.MainRepository
import java.lang.Exception

class MainUseCase(private val repository: MainRepository) {

    private val listAux = arrayListOf<Quotes>()

    suspend fun buscarLista(context: Context): List<Quotes> {
        val response = repository.getLiveCotacao(context)
        if (response.isSucesso()) {
            return criaListaCotacao(response.value)
        } else {
            throw Exception(NETWORK_ERROR)
        }
    }

    private fun criaListaCotacao(value: Live?): List<Quotes> {
        value?.let {
            it.quotes?.let { code ->
                for (key in code.keys) {
                    it.quotes[key]?.let { cotacao ->
                        listAux.add(
                            Quotes(key, cotacao.toDouble())
                        )
                    }
                }
            }
        }
        if (!listAux.isNullOrEmpty()) {
            listAux.sortBy { it.code }
            return listAux
        } else {
            throw Exception(NETWORK_ERROR)
        }
    }

    fun getCotacaoLocal(
        context: Context,
        value: String,
        origem: String,
        destino: String
    ): Double {

        if (listAux.isNullOrEmpty()) {
            val response = repository.getLocal(context)
            criaListaCotacao(response)
        }

        return when {
            isDolar(origem) -> converter(value, getQuot(origem + destino))
            isDolar(destino) -> converter(value, getQuot(destino + origem))
            else -> {
                val quot = getQuot(USD + origem)
                converter(value, quot)
            }
        }
    }

    private fun getQuot(string: String): Double {
        var quot = 0.0
        for (list in listAux) {
            if (list.code == string) {
                quot = list.cotacao
                break
            }
        }

        return quot
    }

    private fun converter(origem: String, destino: Double): Double {
        return origem.toDouble() * destino
    }

    private fun isDolar(moeda: String): Boolean {
        return moeda == USD
    }

}