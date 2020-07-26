package com.example.myapplication.core.repository

import android.content.Context
import android.util.Log
import com.android.volley.DefaultRetryPolicy
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.example.myapplication.R
import com.example.myapplication.features.coinsconverterlist.CoinsConverterInterface
import com.example.myapplication.features.coinsconverterlist.CoinsConverterListResult
import com.google.gson.Gson


class CoinsConverterListRepository (private var context: Context?, private var url: String?){

    fun startRequest(coinsConverterInterface: CoinsConverterInterface) {
        val queue= Volley.newRequestQueue(context)
        val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, url, null, Response.Listener { response ->
            val data= response.toString()
            val result = Gson().fromJson(data, CoinsConverterListResult::class.java)

            coinsConverterInterface.onValidateRequestSuccess(result)
        }, Response.ErrorListener { error ->
            Log.d("ERROR: ", error.toString())
            coinsConverterInterface.onValidateRequestFail(context?.getString(R.string.title_fail_to_connect), error = true)
        })

        jsonObjectRequest.retryPolicy= DefaultRetryPolicy(
            10000,
            DefaultRetryPolicy.DEFAULT_MAX_RETRIES + 1,
            DefaultRetryPolicy.DEFAULT_BACKOFF_MULT
        )
        queue.add(jsonObjectRequest)
    }
}