package br.com.alanminusculi.btgchallenge

import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.exceptions.ConversionException
import br.com.alanminusculi.btgchallenge.utils.CurrencyConverterService
import org.junit.Assert
import org.junit.Before
import org.junit.Test

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrencyConverterServiceUnitTests {

    var usd: CurrencyValue? = null
    var brl: CurrencyValue? = null
    var ars: CurrencyValue? = null

    @Before
    fun setUp() {
        usd = CurrencyValue(0, "USDUSD", 1.0)
        brl = CurrencyValue(0, "USDBRL", 5.342801)
        ars = CurrencyValue(0, "USDARS", 93.433101)
    }

    @Test(expected = ConversionException::class)
    @Throws(ConversionException::class)
    fun convertWithNotUsdAsDefaultThrowsExcption() {
        CurrencyConverterService(brl, brl, ars).convert(1.0)
    }

    @Test(expected = ConversionException::class)
    @Throws(ConversionException::class)
    fun convertWithUsdNullThrowsExcption() {
        CurrencyConverterService(null, brl, ars).convert(1.0)
    }

    @Test(expected = ConversionException::class)
    @Throws(ConversionException::class)
    fun convertWithSourceNullThrowsExcption() {
        CurrencyConverterService(usd, null, ars).convert(1.0)
    }

    @Test(expected = ConversionException::class)
    @Throws(ConversionException::class)
    fun convertWithDestinationNullThrowsExcption() {
        CurrencyConverterService(usd, brl, null).convert(1.0)
    }

    @Test
    @Throws(ConversionException::class)
    fun convertUsdToBrl() {
        val result: Double = CurrencyConverterService(usd, usd, brl).convert(1.0)
        Assert.assertEquals(result, 5.342801, 0.0)
    }

    @Test
    @Throws(ConversionException::class)
    fun convertBrlToArs() {
        val result: Double = CurrencyConverterService(usd, brl, ars).convert(1.0)
        Assert.assertEquals(result, 17.487662557523667, 0.0)
    }
}