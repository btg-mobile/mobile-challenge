package com.example.convertermoeda.repository

import com.example.convertermoeda.retrofit.service.ACCESS_KEY
import com.example.convertermoeda.retrofit.webclient.ResultApi
import com.example.convertermoeda.retrofit.webclient.doRequest
import com.example.convertermoeda.model.Live
import com.example.convertermoeda.provider.providerApi
import retrofit2.awaitResponse

class MainRepository {

    suspend fun getLive(): ResultApi<Live> =
        doRequest(
            providerApi()
                .getCotacao(ACCESS_KEY).awaitResponse()
        )
}