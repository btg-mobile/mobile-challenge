package com.example.mobile_challenge.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
class QuoteEntity(
  @PrimaryKey
  val _id : String,
  val from: String,
  val to: String,
  val value: Double
)