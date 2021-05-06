package com.geocdias.convecurrency.model

data class ExchangeRateModel (
  val fromCurrency: String,
  val toCurrency: String,
  val rate: Double,
  val date: String? = ""
)

