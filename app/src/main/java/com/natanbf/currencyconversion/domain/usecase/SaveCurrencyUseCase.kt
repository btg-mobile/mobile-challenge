package com.natanbf.currencyconversion.domain.usecase

import com.natanbf.currencyconversion.data.local.DataStoreCurrency
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

fun interface SaveCurrencyUseCase : (String, Boolean) -> Flow<Unit>

class SaveCurrencyUseCaseImpl @Inject constructor(
    private val dataStore: DataStoreCurrency,
    private val coroutineDispatcher: CoroutineDispatcher,
) : SaveCurrencyUseCase {
    override fun invoke(item: String, key: Boolean) = flow<Unit> {
        if (key) dataStore.save { copy(from = item) }
        else dataStore.save { copy(to = item) }
    }.flowOn(coroutineDispatcher)

}