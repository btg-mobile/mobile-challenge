package com.example.convertermoeda.usecase

import com.example.convertermoeda.model.Live
import com.example.convertermoeda.repository.MainRepository
import com.example.convertermoeda.retrofit.webclient.ResultApi

class MainUseCase(private val repository: MainRepository) {

    suspend fun buscarLista(): ResultApi<Live> = repository.getLive()
}