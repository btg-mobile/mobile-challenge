package com.rafao1991.mobilechallenge.moneyexchange

import com.rafao1991.mobilechallenge.moneyexchange.domain.ERROR
import com.rafao1991.mobilechallenge.moneyexchange.domain.USD
import org.junit.Test
import org.junit.Assert.assertEquals

class ConstantsUnitTest {
    @Test
    fun assert_constants() {
        assertEquals(ERROR, "Something went wrong during the currency exchange operation.")
        assertEquals(USD, "USD")
    }
}