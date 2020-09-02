package com.example.convertermoeda.repository

import android.content.Context
import com.example.convertermoeda.helper.ACCESS_KEY
import com.example.convertermoeda.helper.COTACAO
import com.example.convertermoeda.helper.DEFAULT
import com.example.convertermoeda.model.Live
import com.example.convertermoeda.provider.providerApi
import com.example.convertermoeda.retrofit.webclient.ResultApi
import com.example.convertermoeda.retrofit.webclient.doRequest
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.awaitResponse

class MainRepository {

    suspend fun getLiveCotacao(context: Context): ResultApi<Live> {
        val result =  doRequest(providerApi().getCotacao(ACCESS_KEY).awaitResponse())

        savarLoval(context, result)

        return result
    }

    private suspend fun savarLoval(
        context: Context,
        result: ResultApi<Live>
    ) {
        withContext(Dispatchers.IO){
            save(context = context, key = COTACAO, obj = result?.value?.let { it })
        }
    }

    private fun save(context: Context, key: String?, obj: Live?) {
        val toJson = Gson().toJson(obj)
        val edit = context.getSharedPreferences(DEFAULT, 0).edit()
        edit.putString(key, toJson).apply()
    }

    fun getLocal(context: Context): Live? {
        val sharedPreferences = context.getSharedPreferences(DEFAULT, 0)
        val json = sharedPreferences.getString(COTACAO, "")
        return Gson().fromJson(json, Live::class.java)
    }
}