package com.example.exchange.viewmodel

import android.view.View
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

    private val loading: MutableLiveData<Int> = MutableLiveData()
    private val data: MutableLiveData<List<Coin>> = MutableLiveData()

    fun requestData() {
        View.VISIBLE.also { loading.value = it }

        Network.getEndpoint()?.getListCoins()?.enqueue(object : Callback<ListCoin> {
            override fun onResponse(call: Call<ListCoin>, response: Response<ListCoin>) {
                View.GONE.also { loading.value = it }
                createDataList(response.body()?.currencies).also { data.value = it }
            }

            override fun onFailure(call: Call<ListCoin>, t: Throwable) {
                View.GONE.also { loading.value = it }
            }
        })
    }

    fun getLoading(): LiveData<Int> {
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