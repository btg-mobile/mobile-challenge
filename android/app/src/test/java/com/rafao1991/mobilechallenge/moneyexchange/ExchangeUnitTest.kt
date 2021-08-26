package com.rafao1991.mobilechallenge.moneyexchange

import com.rafao1991.mobilechallenge.moneyexchange.domain.Exchange
import org.junit.Test

import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Before
import java.lang.Exception

class ExchangeUnitTest {
    lateinit var exchange: Exchange

    private val usd = "USD"
    private val brl = "BRL"
    private val gbp = "GBP"
    private val kgs = "KGS"
    private val xxx = "XXX"

    private val amount = 100.00
    private val delta = 0.0000000001

    private val quotes = HashMap<String, Double>()

    @Before
    fun setup() {
        quotes[usd + brl] = 5.342801
        quotes[usd + gbp] = 0.716315
        quotes[usd + kgs] = 84.795339
    }

    @Test
    fun exchange_USDBRL() {
        exchange = Exchange(amount, usd, brl, quotes)
        assertEquals(exchange.getExchanged(), 534.2801, delta)
    }

    @Test
    fun exchange_BRLUSD() {
        exchange = Exchange(amount, brl, usd, quotes)
        assertEquals(exchange.getExchanged(), 18.71677421637078, delta)
    }

    @Test
    fun exchange_USDGBP() {
        exchange = Exchange(amount, usd, gbp, quotes)
        assertEquals(exchange.getExchanged(), 71.6315, delta)
    }

    @Test
    fun exchange_GBPUSD() {
        exchange = Exchange(amount, gbp, usd, quotes)
        assertEquals(exchange.getExchanged(), 139.6033867781632, delta)
    }

    @Test
    fun exchange_USDKGS() {
        exchange = Exchange(amount, usd, kgs, quotes)
        assertEquals(exchange.getExchanged(), 8479.5339, delta)
    }

    @Test
    fun exchange_KGSUSD() {
        exchange = Exchange(amount, kgs, usd, quotes)
        assertEquals(exchange.getExchanged(), 1.179310103353676, delta)
    }

    @Test
    fun exchange_BRLGBP() {
        exchange = Exchange(amount, brl, gbp, quotes)
        assertEquals(exchange.getExchanged(), 13.40710612279964, delta)
    }

    @Test
    fun exchange_GBPBRL() {
        exchange = Exchange(amount, gbp, brl, quotes)
        assertEquals(exchange.getExchanged(), 745.8731144817571, delta)
    }

    @Test
    fun exchange_BRLKGS() {
        exchange = Exchange(amount, brl, kgs, quotes)
        assertEquals(exchange.getExchanged(), 1587.09521466362, delta)
    }

    @Test
    fun exchange_KGSBRL() {
        exchange = Exchange(amount, kgs, brl, quotes)
        assertEquals(exchange.getExchanged(), 6.300819199508123, delta)
    }

    @Test
    fun exchange_GBPKGS() {
        exchange = Exchange(amount, gbp, kgs, quotes)
        assertEquals(exchange.getExchanged(), 11837.71650740247, delta)
    }

    @Test
    fun exchange_KGSGBP() {
        exchange = Exchange(amount, kgs, gbp, quotes)
        assertEquals(exchange.getExchanged(), 0.8447575166837884, delta)
    }

    @Test
    fun exchange_error() {
        assertThrows(Exception::class.java) {
            exchange = Exchange(amount, xxx, gbp, quotes)
            exchange.getExchanged()
        }

        assertThrows(Exception::class.java) {
            exchange = Exchange(amount, usd, xxx, quotes)
            exchange.getExchanged()
        }
    }
}