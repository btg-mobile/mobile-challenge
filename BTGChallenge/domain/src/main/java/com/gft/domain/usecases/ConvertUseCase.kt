package com.gft.domain.usecases

import com.gft.domain.repository.CurrencyRepository

class ConvertUseCase(
    private val repository: CurrencyRepository
) {
    suspend fun execute(from: String?, to: String?, value: Double?): Double? {
        val values = getValues()
        return values.data?.quotes?.let { convert(from, to , value, it) }
    }

    private suspend fun getValues() =
        repository.getValues()


    private fun convert(
        from: String?,
        to: String?,
        value: Double?,
        list: Map<String, String>
    ): Double {
        val usdValue = getUsdValue(from, value, list)
        val usdRelation = getValue(to, usdValue, list)

        return formatDouble(usdRelation)
    }

    private fun getValue(to: String?, value: Double?, list: Map<String, String>): Double {
        val cotacao = list["USD$to"]?.toDouble()
        return if (value != null) {
            value * cotacao!!
        } else 0.0
    }

    private fun getUsdValue(from: String?, value: Double?, list: Map<String, String>): Double {
        val cotacao = list["USD$from"]?.toDouble()
        return if (value != null) {
            value / cotacao!!
        } else {
            0.0
        }
    }

    private fun formatDouble(value: Double): Double {
        return String.format("%.2f", value).toDouble()
    }
}