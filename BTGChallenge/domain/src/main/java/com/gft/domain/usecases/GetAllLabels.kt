package com.gft.domain.usecases

import com.gft.domain.common.BaseFlowableUseCase
import com.gft.domain.common.FlowableRxTransformer
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable

class GetAllLabels(
    private val transformer: FlowableRxTransformer<CurrencyLabelList>,
    private val repository: CurrencyRepository
) : BaseFlowableUseCase<CurrencyLabelList>(transformer) {

    override fun createFlowable(data: Map<String, Any>?): Flowable<CurrencyLabelList> {
        return repository.getLabels()
    }

    fun getLabels(): Flowable<CurrencyLabelList> {
        val data = HashMap<String, String>()
        return single(data)
    }
}