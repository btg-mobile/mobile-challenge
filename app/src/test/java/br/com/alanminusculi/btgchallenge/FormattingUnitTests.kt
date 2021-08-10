package br.com.alanminusculi.btgchallenge

import br.com.alanminusculi.btgchallenge.utils.Formatting
import org.junit.Assert
import org.junit.Before
import org.junit.Test

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class FormattingUnitTests {

    private lateinit var formatting: Formatting

    @Before
    fun setUp() {
        formatting = Formatting()
    }

    @Test
    fun testToString() {
        val result: String = formatting.toString(17.487662557523667)
        Assert.assertEquals("17,49", result)
    }

    @Test
    fun testToDouble() {
        val result: Double = formatting.toDouble("17,49")
        Assert.assertEquals(17.49, result, 0.0)
    }

    @Test
    fun testToDoubleReturnsZeroWithInvalidValue() {
        val result: Double = formatting.toDouble("abc")
        Assert.assertEquals(0.0, result, 0.0)
    }
}