package com.example.mobile_challenge.model

import kotlinx.serialization.Serializable

@Serializable
class ListResponse(
  val success: Boolean,
  val terms: String,
  val privacy: String,
  val currencies: Map<String, String>
)

data class Currency(
  val currencyCode: String,
  val currencyName: String
) {
  override fun equals(other: Any?): Boolean {
    other as Currency

    if (currencyCode != other.currencyCode) {
      return false
    }
    if (currencyName != other.currencyName) {
      return false
    }
    return true
  }
}
