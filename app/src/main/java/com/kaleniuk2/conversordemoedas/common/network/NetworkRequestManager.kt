package com.kaleniuk2.conversordemoedas.common.network

import android.os.AsyncTask
import android.util.Log
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

class NetworkRequestManager(private val callback: (NetworkRequestManagerResult) -> Unit) : AsyncTask<String, Unit, NetworkRequestManagerResult>() {
    private fun makeRequest(endPoint: String?): NetworkRequestManagerResult {
        if (endPoint == null) return NetworkRequestManagerResult(isSuccess = false)
        try {
            val url = URL("${NetworkConstants.API_URL}$endPoint${NetworkConstants.API_KEY}")
            val urlConnection = url.openConnection() as HttpURLConnection

            if (urlConnection.responseCode == HttpURLConnection.HTTP_OK) {
              val response = readStream(urlConnection.inputStream)
              return NetworkRequestManagerResult(isSuccess = true, success = response)
            }
        } catch(e: Exception) {
            NetworkRequestManagerResult(isSuccess = false, failure = e.message.toString())
        }
        return NetworkRequestManagerResult(isSuccess = false)
    }

    override fun doInBackground(vararg params: String?): NetworkRequestManagerResult {
        return makeRequest(params[0])
    }

    override fun onPostExecute(result: NetworkRequestManagerResult) {
        super.onPostExecute(result)

        callback(result)

    }

    private fun readStream(`in`: InputStream): String? {
        var reader: BufferedReader? = null
        val response = StringBuffer()
        try {
            reader = BufferedReader(InputStreamReader(`in`))
            var line: String? = ""
            while (reader.readLine().also({ line = it }) != null) {
                response.append(line)
            }
        } catch (e: IOException) {
            e.printStackTrace()
        } finally {
            if (reader != null) {
                try {
                    reader.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }
        return response.toString()
    }

}

data class NetworkRequestManagerResult(
    val success: String? = null,
    val failure: String? = null,
    val isSuccess: Boolean
)