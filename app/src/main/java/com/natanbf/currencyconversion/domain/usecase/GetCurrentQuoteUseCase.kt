package com.natanbf.currencyconversion.domain.usecase

import com.natanbf.currencyconversion.domain.model.CurrencyModel
import com.natanbf.currencyconversion.util.Result
import com.natanbf.currencyconversion.domain.repository.CurrencyConverterRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.onStart
import javax.inject.Inject

fun interface GetCurrentQuoteUseCase : () -> Flow<Result<CurrencyModel>>

class GetCurrentQuoteUseCaseImpl @Inject constructor(private val repository: CurrencyConverterRepository) :
    GetCurrentQuoteUseCase {
    override fun invoke(): Flow<Result<CurrencyModel>> = flow {
        repository.getCurrentQuote
            .onStart { emit(Result.Loading) }
            .catch { throwable ->
                Result.Error(message = throwable.message, throwable = throwable)
            }
            .collect { emit(Result.Success(data = it)) }
    }

}