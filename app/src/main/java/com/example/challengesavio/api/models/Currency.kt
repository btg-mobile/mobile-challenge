package com.example.challengesavio.api.models

import java.io.Serializable

data class Currency(
    val acronym: String? = null,
    val name: String? = null
) : Serializable