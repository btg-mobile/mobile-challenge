package com.kaleniuk2.conversordemoedas.data.parser

import com.kaleniuk2.conversordemoedas.util.JSONUtil
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import org.json.JSONObject

object CurrencyParser {
    fun toListCurrencies(responseJSONObject: JSONObject): DataWrapper<List<Currency>?> {
        return if (responseJSONObject.getBoolean("success")) {
            try {
                val map =
                    JSONUtil.toMap(responseJSONObject.getJSONObject("currencies")) as Map<String, String>
                val listCurrency = mutableListOf<Currency>()

                map.forEach { item ->
                    listCurrency.add(Currency(item.value, item.key))
                }

                DataWrapper.Success(listCurrency)

            } catch (e: Exception) {
                DataWrapper.Error("Erro ao efetuar pesquisa")
            }
        } else {
            DataWrapper
                .Error(responseJSONObject.getJSONObject("error").getString("info"))
        }
    }
}