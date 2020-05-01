package com.example.mobile_challenge.utility

import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.http.takeFrom

class ClientApi {

    private val URL = "http://api.currencylayer.com"
    private val KEY = "e8af0ceaeac239335961d0151a4507b7"

    private val client = HttpClient(OkHttp)

    suspend fun httpRequestGetList(): String {
        return client.get {
            parameter("access_key", KEY )
            url {
                takeFrom(URL)
                encodedPath = "/list"
            }
        }
    }

    suspend fun httpRequestGetLive(): String {
        return client.get {
            parameter("access_key", KEY )
            url {
                takeFrom(URL)
                encodedPath = "/live"
            }
        }
    }
}