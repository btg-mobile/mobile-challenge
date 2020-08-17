package com.gft.data.datasource

import androidx.lifecycle.LiveData
import com.gft.data.model.CurrencyLabelListModel
import com.gft.domain.entities.Resource
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable
import retrofit2.Response

interface CurrencyRemoteDataSource {
    suspend fun getLabels() : Resource<CurrencyLabelList>

    fun getValues() : Flowable<CurrencyValueList>
}