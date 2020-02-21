package com.example.alesefsapps.conversordemoedas.data.result

sealed class LiveValueResult {
    class Success : LiveValueResult()
    class ApiError(val statusCode: Int) : LiveValueResult()
    class SeverError : LiveValueResult()
}