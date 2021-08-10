package br.com.alanminusculi.btgchallenge

import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import org.junit.Assert
import org.junit.Test

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrencyValueUnitTests {

    @Test
    fun testIsUsd() {
        val usd = CurrencyValue(0, "USDUSD", 1.0)
        val brl = CurrencyValue(0, "USDBRL", 5.342801)

        Assert.assertTrue(usd.isUsd())
        Assert.assertFalse(brl.isUsd())
    }
}