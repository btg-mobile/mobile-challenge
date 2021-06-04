package com.example.exchange.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.exchange.model.Coin
import com.example.exchange.model.ListCoin
import com.example.exchange.utils.Network
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CoinViewModel : ViewModel() {

    private val loading: MutableLiveData<Boolean> = MutableLiveData()
    private val data: MutableLiveData<List<Coin>> = MutableLiveData()

    fun requestData() {
        true.also { loading.value = it }

        Network.getEndpoint()?.getListCoins()?.enqueue(object : Callback<ListCoin> {
            override fun onResponse(call: Call<ListCoin>, response: Response<ListCoin>) {
                false.also { loading.value = it }
                createDataList(response.body()?.currencies).also { data.value = it }
            }

            override fun onFailure(call: Call<ListCoin>, t: Throwable) {
                false.also { loading.value = it }
            }
        })
    }

    fun getLoading(): LiveData<Boolean> {
        return loading
    }

    fun getData(): LiveData<List<Coin>> {
        return data
    }

    fun createDataList(data: Map<String, String>?): List<Coin> {
        val list: MutableList<Coin> = mutableListOf()

        data?.forEach { (k, v) ->
            list.add(Coin(k, v))
        }

        return list
    }
}