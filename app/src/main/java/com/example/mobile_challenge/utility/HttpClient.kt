package com.example.mobile_challenge.utility

import com.example.mobile_challenge.model.ListRequest
import com.example.mobile_challenge.model.LiveRequest
import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.accept
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.http.takeFrom
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration

class ClientApi {

    private val URL = "http://api.currencylayer.com"
    private val KEY = "359daed36ec00b5244e6f907c493f571"

    private val client = HttpClient(OkHttp) {
        install(JsonFeature) {
            val kxs = KotlinxSerializer(Json(JsonConfiguration.Stable.copy(prettyPrint = true)))
            serializer = kxs
        }
    }

    suspend fun httpRequestGetList(): ListRequest {
        return client.get {
            parameter("access_key", KEY )
            url {
                takeFrom(URL)
                encodedPath = "/list"
            }
        }
    }

    suspend fun httpRequestGetLive(): LiveRequest {
        return client.get {
            parameter("access_key", KEY )
            url {
                takeFrom(URL)
                encodedPath = "/live"
            }
        }
    }
}