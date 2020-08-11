package com.gft.domain.usecases

import com.gft.domain.common.BaseFlowableUseCase
import com.gft.domain.common.FlowableRxTransformer
import com.gft.domain.entities.CurrencyList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable

class GetAllLabels(
    private val transformer: FlowableRxTransformer<CurrencyList>,
    private val repository: CurrencyRepository
) : BaseFlowableUseCase<CurrencyList>(transformer) {

    override fun createFlowable(data: Map<String, Any>?): Flowable<CurrencyList> {
        return repository.getAllLabels()
    }

    fun getLabels(): Flowable<CurrencyList> {
        val data = HashMap<String, String>()
        return single(data)
    }
}