package com.gft.domain.usecases

import com.gft.domain.common.BaseFlowableUseCase
import com.gft.domain.common.FlowableRxTransformer
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.repository.CurrencyRepository
import io.reactivex.Flowable

class GetLabelsUseCase(
    private val repository: CurrencyRepository
) {

    suspend fun execute() = repository.getLabels()

}