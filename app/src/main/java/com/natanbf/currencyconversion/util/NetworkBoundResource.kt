package com.natanbf.currencyconversion.util

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.emitAll
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map

inline fun <ResultType, RequestType> networkBoundResource(
    crossinline query: () -> Flow<ResultType>,
    crossinline fetch: suspend () -> RequestType,
    crossinline saveFetchResult: suspend (RequestType) -> Unit,
    crossinline shouldFetch: (ResultType) -> Boolean = { true }
) = flow {
    val data = query().first()

    val resource = if (shouldFetch(data)) {

        emit(Result.Loading)

        try {
            val resultType = fetch()
            saveFetchResult(resultType)
            query().map { Result.Success(it) }
        } catch (throwable: Throwable) {
            query().map { Result.Error(message = throwable.message, throwable = throwable) }
        }

    } else query().map { Result.Success(it) }

    emitAll(resource)
}