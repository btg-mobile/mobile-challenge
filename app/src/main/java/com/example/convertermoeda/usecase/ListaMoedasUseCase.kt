package com.example.convertermoeda.usecase

import android.content.Context
import com.example.convertermoeda.helper.NETWORK_ERROR
import com.example.convertermoeda.model.Currencies
import com.example.convertermoeda.model.ListMoeda
import com.example.convertermoeda.repository.ListaMoedasRepository
import java.lang.Exception

class ListaMoedasUseCase(private val repository: ListaMoedasRepository) {

    suspend fun getListaMoedas(context: Context): List<Currencies> {

        val response = repository.getListaMoedas(context)

        if (response.isSucesso()) {
            return criaListaDeCodeENome(response.value)
        } else {
            throw Exception(NETWORK_ERROR)
        }
    }

    fun getLocal(context: Context): List<Currencies>? {
        val response = repository.getLocal(context)
        response?.let {
            return criaListaDeCodeENome(value = it)
        }

        return null
    }

    private fun criaListaDeCodeENome(value: ListMoeda?): List<Currencies> {
        val listAux = arrayListOf<Currencies>()
        value?.let {
            it.currencies?.let { code ->
                for (key in code.keys) {
                    it.currencies[key]?.let { name ->
                        listAux.add(
                            Currencies(key, name)
                        )
                    }
                }
            }
        }
        if (!listAux.isNullOrEmpty()) {
            listAux.sortBy { it.nome }
            return listAux
        } else {
            throw Exception(NETWORK_ERROR)
        }
    }
}