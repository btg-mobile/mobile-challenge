package com.gft.domain.usecases

import com.gft.domain.repository.CurrencyRepository
import io.reactivex.BackpressureStrategy
import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers

class ConvertUseCase(
    private val repository: CurrencyRepository
) {
    fun execute(from: String?, to: String?, value: Double?): Flowable<Double> {
        return Flowable.create({ emitter ->
            repository.getValues().subscribeOn(Schedulers.io())
                .subscribe(
                    { response ->
                        emitter.onNext(
                            convert(
                                from = from,
                                to = to,
                                value = value,
                                list = response.quotes!!
                            )
                        )

                    },
                    { error ->
                        println(error)

                    }
                )
        }, BackpressureStrategy.BUFFER)
    }

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