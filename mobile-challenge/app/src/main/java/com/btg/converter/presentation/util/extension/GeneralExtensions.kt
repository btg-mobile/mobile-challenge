package com.btg.converter.presentation.util.extension

fun consume(f: () -> Unit): Boolean {
    f()
    return true
}

suspend fun <RESULT> handleException(
    exceptionHandler: suspend (Throwable) -> RESULT?,
    block: suspend () -> RESULT?
): RESULT? {
    return try {
        block()
    } catch (e: Exception) {
        exceptionHandler(e)
    }
}