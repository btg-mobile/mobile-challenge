package com.example.mobile_challenge.model

import kotlinx.serialization.Serializable

@Serializable
class LiveResponse(
  val success: Boolean,
  val terms: String,
  val privacy: String,
  val timestamp: Long,
  val source: String,
  val quotes: Map<String, Double>
)