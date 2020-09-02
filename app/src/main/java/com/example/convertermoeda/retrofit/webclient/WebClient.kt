package com.example.convertermoeda.retrofit.webclient

import retrofit2.Response

fun <T> doRequest(response: Response<T>): ResultApi<T> {
    return if (response.isSuccessful) {
        ResultApi.createSucesso(
            response.body()!!
        )
    } else {
        ResultApi.createErro(response.message())
    }
}