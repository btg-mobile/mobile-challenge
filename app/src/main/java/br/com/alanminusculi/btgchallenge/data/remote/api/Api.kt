package br.com.alanminusculi.btgchallenge.data.remote.api

import br.com.alanminusculi.btgchallenge.data.remote.dtos.ListDTO
import br.com.alanminusculi.btgchallenge.data.remote.dtos.LiveDTO
import retrofit2.Call
import retrofit2.http.GET

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

interface Api {

    @GET("list")
    fun list(): Call<ListDTO?>?

    @GET("live")
    fun live(): Call<LiveDTO?>?
}