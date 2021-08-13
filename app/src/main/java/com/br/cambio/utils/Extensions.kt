package com.br.cambio.utils

import com.br.cambio.data.model.Result

object Extensions{
    fun isNullOrEmpty(data: Result?): Boolean {
        return data == null
    }
}