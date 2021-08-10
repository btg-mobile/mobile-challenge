package br.com.alanminusculi.btgchallenge.ui.converter

import androidx.databinding.Observable
import androidx.databinding.Observable.OnPropertyChangedCallback
import androidx.databinding.ObservableBoolean
import androidx.databinding.ObservableDouble
import androidx.databinding.ObservableField
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.exceptions.ConversionException
import br.com.alanminusculi.btgchallenge.utils.CurrencyConverterService
import br.com.alanminusculi.btgchallenge.utils.Formatting
import java.lang.Exception

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class ConverterViewModel(defaultCurrency: Currency, private val defaultPrice: CurrencyValue) {

    private var converted = false

    val formatting = Formatting()
    var sourcePrice: CurrencyValue? = defaultPrice
    var destinationPrice: CurrencyValue? = defaultPrice
    var sourceCurrency = ObservableField(defaultCurrency)
    var destinationCurrency = ObservableField(defaultCurrency)
    var sourceValue = ObservableDouble(1.0)
    var destinationValue = ObservableDouble(1.0)
    var valid = ObservableBoolean(true)
    var error = ObservableField<String>()

    init {
        sourceValue.addOnPropertyChangedCallback(getSourceValuePropertyChangedCallback())
    }

    fun numberPressed(number: Int) {
        if (converted) sourceValue.set(0.0)
        sourceValue.set(insertNumber(sourceValue.get(), number))
        converted = false
    }

    fun convert() {
        error.set(null)
        try {
            val value = sourceValue.get()
            val result: Double = CurrencyConverterService(defaultPrice, sourcePrice, destinationPrice).convert(value)
            destinationValue.set(result)
            converted = true
        } catch (exception: ConversionException) {
            error.set(exception.message)
        }
    }

    fun clear() {
        sourceValue.set(1.0)
        convert()
    }

    fun setSource(currency: Currency, price: CurrencyValue) {
        sourceCurrency.set(currency)
        sourcePrice = price
        convert()
    }

    fun setDestination(currency: Currency, price: CurrencyValue) {
        destinationCurrency.set(currency)
        destinationPrice = price
        convert()
    }

    private fun insertNumber(valor: Double, numero: Int): Double {
        return try {
            val decimais = 2
            var valorStr: String = formatting.toString(valor)
            valorStr = valorStr.replace(".", ",")
            valorStr = valorStr.replace(",", "")
            valorStr += numero
            valorStr = String.format("%s.%s", valorStr.substring(0, valorStr.length - decimais), valorStr.substring(valorStr.length - decimais))
            valorStr.toDouble()
        } catch (var5: Exception) {
            0.0
        }
    }

    private fun getSourceValuePropertyChangedCallback(): OnPropertyChangedCallback {
        return object : OnPropertyChangedCallback() {
            override fun onPropertyChanged(sender: Observable, propertyId: Int) {
                val value = sourceValue.get()
                valid.set(value > 0)
            }
        }
    }
}