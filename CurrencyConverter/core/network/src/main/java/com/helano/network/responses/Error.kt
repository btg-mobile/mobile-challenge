package com.helano.network.responses

data class Error(
 val code: Int = 0,
 val type: String = "",
 val info: String = ""
)
