package com.rafao1991.mobilechallenge.moneyexchange.util

const val UNKNOWN_VIEW_MODEL_CLASS = "Unknown ViewModel class"

const val ERROR = "Something went wrong during the currency exchange operation."
const val USD = "USD"
const val BRL = "BRL"

const val EXCHANGE_DATABASE = "exchange_database"
const val CURRENCY = "currency"
const val SELECTED_CURRENCY = "selected_currency"
const val QUOTE = "quote"
const val ID = "id"
const val TYPE = "type"
const val EXCHANGE_DATABASE_VERSION = 1

enum class Currency {
    ORIGIN,
    TARGET
}

enum class ApiStatus {
    LOADING,
    ERROR,
    DONE
}