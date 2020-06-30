package br.com.leonamalmeida.mobilechallenge.data.source.remote

import br.com.leonamalmeida.mobilechallenge.data.Currency
import br.com.leonamalmeida.mobilechallenge.data.Rate
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import okhttp3.ResponseBody

/**
 * Created by Leo Almeida on 29/06/20.
 */

fun findRequestStatus(responseString: String): Boolean {
    val booleanToken = TypeToken.get(HashMap<String, Boolean>().javaClass)
    return Gson().fromJson<Map<String, Boolean>>(responseString, booleanToken.type)["success"]
        ?: false
}

fun getErrorMessage(responseString: String): String {
    val typeToken = TypeToken.get(HashMap<String, Any?>().javaClass)

    val error = Gson().fromJson<Map<String, Any>>(
        responseString,
        typeToken.type
    )["error"] as Map<String, Any>

    val msgBuilder = StringBuilder()
    error.forEach { (key, value) -> msgBuilder.append("$key: $value\n") }
    return msgBuilder.toString()
}

fun getCurrencies(responseString: String): List<Currency> {
    val typeToken = TypeToken.get(HashMap<String, Any?>().javaClass)

    val currencies = Gson().fromJson<Map<String, String>>(
        responseString,
        typeToken.type
    )["currencies"] as Map<String, String>

    return currencies.map {
        Currency(
            it.key,
            it.value
        )
    }
}

fun getRates(responseString: String): List<Rate> {
    val typeToken = TypeToken.get(HashMap<String, Float>().javaClass)

    val quotes = Gson().fromJson<Map<String, Any?>>(
        responseString,
        typeToken.type
    )["quotes"] as Map<String, Float>

    val lastUpdate =
        getLastUpdate(
            responseString
        )

    return quotes.map {
        Rate(
            code = it.key.removePrefix("USD"),
            value = it.value,
            lastUpdate = lastUpdate
        )
    }
}

fun ResponseBody.currencyMap(): List<Currency> {
    val responseString = string()

    val status =
        findRequestStatus(
            responseString
        )

    if (status) return getCurrencies(
        responseString
    )
    else throw Exception(
        getErrorMessage(
            responseString
        )
    )
}

fun ResponseBody.rateMap(): List<Rate> {
    val responseString = string()

    val status =
        findRequestStatus(
            responseString
        )

    if (status) return getRates(
        responseString
    )
    else throw Exception(
        getErrorMessage(
            responseString
        )
    )
}

fun getLastUpdate(responseString: String): Long {
    val booleanToken = TypeToken.get(HashMap<String, Double>().javaClass)
    return Gson().fromJson<Map<String, Double>>(
        responseString,
        booleanToken.type
    )["timestamp"]?.toLong()
        //UNIX format according CurrencyLayer API Doc. That's why we multiple by 1000L
        ?.let { it * 1000L }
        ?: System.currentTimeMillis()
}
