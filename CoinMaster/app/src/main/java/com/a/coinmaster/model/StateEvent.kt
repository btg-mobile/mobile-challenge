package com.a.coinmaster.model

sealed class StateEvent<T>()
class StateSuccess<T>(val data: T) : StateEvent<T>()
class StateError<T>(val error: Throwable): StateEvent<T>()
class StateLoading<T>(): StateEvent<T>()