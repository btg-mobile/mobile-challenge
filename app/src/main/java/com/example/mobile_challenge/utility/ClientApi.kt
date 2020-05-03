package com.example.mobile_challenge.utility

import com.example.mobile_challenge.model.*
import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.statement.HttpResponse
import io.ktor.http.takeFrom
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json

@OptIn(UnstableDefault::class)
class ClientApi {

  private val url = "http://api.currencylayer.com"
  private val key = "e8af0ceaeac239335961d0151a4507b7"

  private val client = HttpClient(OkHttp)

  suspend fun httpRequestGetList(): ResponseOptionsCurrency {
    val json = client.get<String> {
      parameter("access_key", key)
      url {
        takeFrom(this@ClientApi.url)
        encodedPath = "/list"
      }
    }
    return try {
      val currencyResponse = Json.parse(CurrencyResponse.serializer(), json)
      ResponseOptionsCurrency.SuccessResponse(currencyResponse)
    } catch (e: Exception) {
      try {
        val errorResponse = Json.parse(ErrorResponse.serializer(), json)
        ResponseOptionsCurrency.ErrorResponse(errorResponse.error.info)
      } catch (e: Exception) {
        ResponseOptionsCurrency.ErrorResponse("Connection Error. $e")
      }
    }
  }

  suspend fun httpRequestGetLive(): ResponseOptionsQuote {
    val json = client.get<String> {
      parameter("access_key", key)
      url {
        takeFrom(this@ClientApi.url)
        encodedPath = "/live"
      }
    }
    return try {
      val quoteResponse = Json.parse(QuoteResponse.serializer(), json)
      ResponseOptionsQuote.SuccessResponse(quoteResponse)
    } catch (e: Exception) {
      try {
        val errorResponse = Json.parse(ErrorResponse.serializer(), json)
        ResponseOptionsQuote.ErrorResponse(errorResponse.error.info)
      } catch (e: Exception) {
        ResponseOptionsQuote.ErrorResponse("Connection Error. $e")
      }
    }
  }
}