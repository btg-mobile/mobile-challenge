package com.gft.data.api

import com.gft.data.model.CurrencyLabelListModel
import com.gft.data.model.CurrencyValueListModel
import io.reactivex.Flowable
import retrofit2.http.GET

interface CurrencyApi {
    @GET("list?access_key=502c1ba22d71723556c4142a6cd57156&format=1")
    fun getLabels(): Flowable<CurrencyLabelListModel>

    @GET("live?access_key=502c1ba22d71723556c4142a6cd57156&format=1")
    fun getValues(): Flowable<CurrencyValueListModel>


}