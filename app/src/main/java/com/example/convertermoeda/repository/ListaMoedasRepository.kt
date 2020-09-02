package com.example.convertermoeda.repository

import android.content.Context
import com.example.convertermoeda.helper.ACCESS_KEY
import com.example.convertermoeda.helper.DEFAULT
import com.example.convertermoeda.helper.LISTA_MOEDAS
import com.example.convertermoeda.model.ListMoeda
import com.example.convertermoeda.provider.providerApi
import com.example.convertermoeda.retrofit.webclient.ResultApi
import com.example.convertermoeda.retrofit.webclient.doRequest
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.awaitResponse

class ListaMoedasRepository {

    suspend fun getListaMoedas(context: Context): ResultApi<ListMoeda> {
        val result =  doRequest(providerApi().getListaMoedas(ACCESS_KEY).awaitResponse())

        savarLoval(context, result)

        return result
    }

    private suspend fun savarLoval(
        context: Context,
        result: ResultApi<ListMoeda>
    ) {
        withContext(Dispatchers.IO){
            save(context = context, key = LISTA_MOEDAS, obj = result?.value?.let { it })
        }
    }

    private fun save(context: Context, key: String?, obj: ListMoeda?) {
        val toJson = Gson().toJson(obj)
        val edit = context.getSharedPreferences(DEFAULT, 0).edit()
        edit.putString(key, toJson).apply()
    }

    fun getLocal(context: Context): ListMoeda? {
        val sharedPreferences = context.getSharedPreferences(DEFAULT, 0)
        val json = sharedPreferences.getString(LISTA_MOEDAS, "")
        return Gson().fromJson(json, ListMoeda::class.java)
    }
}