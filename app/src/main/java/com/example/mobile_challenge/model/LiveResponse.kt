package com.example.mobile_challenge.model

import androidx.room.Entity
import androidx.room.PrimaryKey
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

@Entity
class QuoteEntity(
  @PrimaryKey
  val _id : String,
  val from: String,
  val to: String,
  val value: Double
)