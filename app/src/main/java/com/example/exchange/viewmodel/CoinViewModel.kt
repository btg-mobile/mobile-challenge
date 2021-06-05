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

    private lateinit var items: Map<String, String>

    fun requestData() {
        View.VISIBLE.also { loading.value = it }

        Network.getEndpoint()?.getListCoins()?.enqueue(object : Callback<ListCoin> {
            override fun onResponse(call: Call<ListCoin>, response: Response<ListCoin>) {
                View.GONE.also { loading.value = it }

                response.body()?.currencies.also { it ->
                    if (it != null) {
                        items = it
                        createDataList("")
                    }
                }
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

    fun createDataList(filter: String) {
        val listCoins: MutableList<Coin> = mutableListOf()

        items.forEach { (k, v) ->
            when {
                filter.isNotEmpty() -> {
                    when {
                        filter.toLowerCase().toRegex().containsMatchIn(k.toLowerCase()) || filter.toLowerCase().toRegex().containsMatchIn(v.toLowerCase()) -> {
                            listCoins.add(Coin(k, v))
                        }
                    }
                }
                else -> {
                    listCoins.add(Coin(k, v))
                }
            }
        }

        listCoins.also { data.value = it }
    }
}