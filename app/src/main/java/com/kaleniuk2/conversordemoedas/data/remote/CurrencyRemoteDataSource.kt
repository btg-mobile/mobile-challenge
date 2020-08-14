package com.kaleniuk2.conversordemoedas.data.remote

import android.os.AsyncTask
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.common.network.NetworkRequestManager
import com.kaleniuk2.conversordemoedas.data.parser.CurrencyParser

class CurrencyRemoteDataSource<T>(val callback: (T) -> Unit) :
    AsyncTask<CurrencyRemoteDataSource.END_POINT, Unit, T>() {
    enum class END_POINT {
        LIST, LIVE
    }

    companion object {
        private const val API_URL = "http://api.currencylayer.com/"
        private const val API_KEY = "?access_key=1d08dfaeaf855d465642aa490f115c8f"
        private const val LIST_ENDPOINT = "list"
        private const val LIVE_ENDPOINT = "live"
    }

    override fun doInBackground(vararg params: END_POINT): T {
        when (params[0]) {
            END_POINT.LIST -> {

                return when (val resultJson =
                    NetworkRequestManager.makeRequest("$API_URL$LIST_ENDPOINT$API_KEY")) {
                    is DataWrapper.Success -> {
                        CurrencyParser.toListCurrencies(resultJson.value) as T
                    }
                    is DataWrapper.Error ->
                        DataWrapper.Error(resultJson.error) as T
                }

            }
            END_POINT.LIVE -> {
                return CurrencyDataResponse(false, 0, null) as T
            }
        }
    }

    override fun onPostExecute(result: T) {
        super.onPostExecute(result)
        callback(result)
    }
}