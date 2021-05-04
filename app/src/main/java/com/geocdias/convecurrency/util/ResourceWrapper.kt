package com.geocdias.convecurrency.util

enum class Status {
    SUCCESS,
    ERROR,
    LOADING
}

sealed class ResourceWrapper<T>(val status: Status, val data: T?,  val message: String?) {
    class Success<T>(data: T?): ResourceWrapper<T>(Status.SUCCESS, data,  null)
    class Error<T>(message: String): ResourceWrapper<T>(Status.ERROR, null, message)
    class Loading<T>: ResourceWrapper<T>(Status.LOADING,null,null)
}
