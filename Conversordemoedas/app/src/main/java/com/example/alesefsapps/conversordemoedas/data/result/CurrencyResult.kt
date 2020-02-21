package com.example.alesefsapps.conversordemoedas.data.result

import com.example.alesefsapps.conversordemoedas.data.model.Values

sealed class CurrencyResult {
    class Success(val values: List<Values>) : CurrencyResult()
    class ApiError(val statusCode: Int) : CurrencyResult()
    class SeverError : CurrencyResult()
}