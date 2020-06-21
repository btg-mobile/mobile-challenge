package com.br.btgteste.domain.usecase

import com.br.btgteste.domain.model.ApiResult
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlin.coroutines.CoroutineContext

@Suppress("UNCHECKED_CAST")
abstract class BaseUseCase <Result, in Params, out Response> where Result : Any, Response : Any {

    private var parentJob: Job = Job()
    private var backgroundContext = Dispatchers.IO
    private var foregroundContext = Dispatchers.Main

    abstract suspend fun run(request: Params?): Any
    abstract fun interceptor(request: Params?, response: Result, onResult: (ApiResult<Response>)->Unit)
    fun runAsync(block: () -> Unit) = CoroutineScope(backgroundContext).launch { block() }

    operator fun invoke(params: Params? = null, onResult: (ApiResult<Response>) -> Unit) {
        val exceptionHandler = CoroutineExceptionHandler {
                _: CoroutineContext, throwable: Throwable ->
            onResult(ApiResult.Error(throwable))
        }
        parentJob = Job()
        CoroutineScope(foregroundContext + parentJob + exceptionHandler).launch {
            val result = withContext(backgroundContext) { run(params) }
            interceptor(params, result as Result, onResult)
        }
    }
}