package com.helano.network.responses

data class ErrorResponse(
    val success:  Boolean,
    val error: Error
)