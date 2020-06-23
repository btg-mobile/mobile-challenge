package com.example.currencyconverter

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.DatabaseInstance
import com.example.currencyconverter.logic.ConverterInteractor
import com.example.currencyconverter.presentation.converter.ConverterActivity
import io.reactivex.disposables.CompositeDisposable
import org.junit.Test
import org.junit.Assert.*

class ConverterUnitTest {


    val systemUnderTest = ConverterInteractor(ConverterActivity(), ConverterActivity(), DatabaseInstance(), CompositeDisposable())

    @Test
    fun currencyConversionHappyTest1() {
        systemUnderTest.originalValue = 1.00
        systemUnderTest.originalCurrency = Currency("USD", "Dollar", 1.00)
        systemUnderTest.convertedCurrency = Currency("BRL", "Reais", 5.3265)

        assertEquals(5.3265, systemUnderTest.calculateConvertedValue(), 0.0)
    }

    @Test
    fun currencyConversionHappyTest2() {
        systemUnderTest.originalValue = 10.00
        systemUnderTest.originalCurrency = Currency("USD", "Dollar", 1.00)
        systemUnderTest.convertedCurrency = Currency("BRL", "Reais", 5.3277)

        assertEquals(53.277, systemUnderTest.calculateConvertedValue(),0.0)
    }

    @Test
    fun currencyConversionHappyTest3() {
        systemUnderTest.originalValue = 1000.00000
        systemUnderTest.originalCurrency = Currency("BRA", "Brazil", 2.00)
        systemUnderTest.convertedCurrency = Currency("BRL", "Reais", 4.2266)

        assertEquals(2113.3, systemUnderTest.calculateConvertedValue(), 0.0)
    }
}
