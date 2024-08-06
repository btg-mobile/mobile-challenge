package com.natanbf.currencyconversion.util


sealed interface Resource<out T> {
    data class Success<T>(val result: T) : Resource<T>
    data class Error(val message: String) : Resource<Nothing>

    suspend fun onSuccess(
        executable: suspend (result: T) -> Unit
    ): Resource<T> = apply {
        if (this is Success) {
            executable(result)
        }
    }

    suspend fun onError(
        executable: suspend (message: String?) -> Unit
    ): Resource<T> = apply {
        if (this is Error) {
            executable(message)
        }
    }
}