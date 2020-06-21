package com.br.btgteste.domain.usecase

import com.br.btgteste.domain.model.ApiResult
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlin.coroutines.CoroutineContext

abstract class BaseUseCase <Type, in Params, out Response> where Type : Any, Response : Any {

    private var parentJob: Job = Job()
    private var backgroundContext = Dispatchers.IO
    private var foregroundContext = Dispatchers.Main

    abstract suspend fun run(request: Params?): Type
    abstract fun interceptor(request: Params?, response: Type, onResult: (ApiResult<Response>)->Unit)

    operator fun invoke(params: Params? = null, onResult: (ApiResult<Response>) -> Unit) {
        val exceptionHandler = CoroutineExceptionHandler {
                _: CoroutineContext, throwable: Throwable ->
            onResult(ApiResult.Error(throwable))
        }
        parentJob = Job()
        CoroutineScope(foregroundContext + parentJob + exceptionHandler).launch {
            val result = withContext(backgroundContext) { run(params) }
            interceptor(params, result, onResult)
        }
    }
}