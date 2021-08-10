package br.com.alanminusculi.btgchallenge.data.remote.api

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class ApiHelper {

    companion object {
        private fun getRetrofitInstance(): Retrofit {
            return Retrofit.Builder()
                .baseUrl("https://btg-mobile-challenge.herokuapp.com/")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
        }

        fun getApi(): Api {
            return getRetrofitInstance().create(Api::class.java)
        }
    }
}