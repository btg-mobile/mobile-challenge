package com.example.convertermoeda.retrofit.webclient

import com.example.convertermoeda.model.Live
import retrofit2.Response

fun doRequest(response: Response<Live>): ResultApi<Live> {
    return if (response.isSuccessful) {
        ResultApi.createSucesso(
            response.body()!!
        )
    } else {
        ResultApi.createErro(response.message())
    }
}