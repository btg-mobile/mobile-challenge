package com.rafao1991.mobilechallenge.moneyexchange.domain

const val ERROR = "Something went wrong during the currency exchange operation."
const val USD = "USD"
const val BRL = "BRL"

enum class Currency {
    ORIGIN,
    TARGET
}

enum class ApiStatus {
    LOADING,
    ERROR,
    DONE
}