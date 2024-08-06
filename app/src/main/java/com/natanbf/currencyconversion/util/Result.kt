package com.natanbf.currencyconversion.util

sealed interface Result<out T> {
    data class Success<T>(val data: T) : Result<T>
    data class Error(val message: String?, val throwable: Throwable? = null) : Result<Nothing>
    data object Loading : Result<Nothing>

    suspend fun onSuccess(
        executable: suspend (data: T) -> Unit
    ): Result<T> = apply {
        if (this is Success) {
            executable(data)
        }
    }

    suspend fun onError(
        executable: suspend (message: String?, exception: Throwable?) -> Unit
    ): Result<T> = apply {
        if (this is Error) {
            executable(message, throwable)
        }
    }

    suspend fun onLoading(
        executable: suspend () -> Unit
    ): Result<T> = apply {
        if (this is Loading) {
            executable()
        }
    }
}