package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.entities.CurrencyValueList
import io.reactivex.Flowable

class CurrencyLocalDataSourceImpl() :
    CurrencyLocalDataSource {
    override fun getAllLabels(): List<CurrencyLabel> {
        TODO("Not yet implemented")
    }

    override fun getValues(): Flowable<CurrencyValueList> {
        TODO("Not yet implemented")
    }


}