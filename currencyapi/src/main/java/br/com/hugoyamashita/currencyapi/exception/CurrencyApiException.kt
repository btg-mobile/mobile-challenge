package br.com.hugoyamashita.currencyapi.exception

import java.lang.RuntimeException

class CurrencyApiException(message: String?, cause: Throwable?) : RuntimeException(message, cause) {

    constructor(cause: Throwable) : this("Error while executing CurrencyLayer API", cause)

    constructor(message: String) : this(message, Throwable())

}