package br.com.alanminusculi.btgchallenge.utils

import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.exceptions.ConversionException

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrencyConverterService(
    val defaultPrice: CurrencyValue?,
    val sourcePrice: CurrencyValue?,
    val destinationPrice: CurrencyValue?
) {

    @Throws(ConversionException::class)
    fun convert(value: Double): Double {
        if (value == 0.0) throw ConversionException("O valor original informado deve ser maior que zero.")
        if (defaultPrice == null || !defaultPrice.isUsd()) throw ConversionException("Cotação para Dólar Americano não informada.")
        if (sourcePrice == null) throw ConversionException("Cotação da moeda de origem não informada.")
        if (destinationPrice == null) throw ConversionException("Cotação da moeda de destino não informada.")
        val dollars: Double = 1 / sourcePrice.value
        val index: Double = dollars * destinationPrice.value
        return index * value
    }
}