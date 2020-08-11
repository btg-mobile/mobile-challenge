package com.gft.data.datasource

import androidx.lifecycle.MutableLiveData
import com.gft.core.Constants
import com.gft.core.CurrencyApi
import com.gft.core.NetworkCall
import com.gft.core.Resource
import com.gft.data.model.CurrenciesLabelModel

class CurrencyRemoteDataSourceImpl(private val currencyApi: CurrencyApi) :
    CurrencyRemoteDataSource {
    override fun getAllLabels(): MutableLiveData<Resource<CurrenciesLabelModel>> {
        return NetworkCall<CurrenciesLabelModel>().makeCall(currencyApi.getAll(Constants.API_KEY))
    }


    override fun convert(from: String, to: String, value: Double): Double {
        TODO("Not yet implemented")
    }

}