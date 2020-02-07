package br.com.hugoyamashita.currencyapi

import br.com.hugoyamashita.currencyapi.di.unitTestKodein
import org.hamcrest.Matchers.`is`
import org.hamcrest.Matchers.greaterThan
import org.hamcrest.Matchers.notNullValue
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertThat
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Test
import org.kodein.di.generic.instance

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class CurrencyLayerServiceUnitTest {

    @Test
    fun `Mocked service - Successful currencies request`() {
        val service: CurrencyLayerService by unitTestKodein.instance("serviceSuccessfulCurrenciesRequest")
        service.getCurrencies()
            .doOnSuccess {
                // Service response
                assertNotNull(it)
                assertTrue(it.success)

                // Currencies
                assertNotNull(it.currencies)
                assertThat(it.currencies.size, greaterThan(0))
            }
            .doOnError {
                fail("This test should not get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

    @Test
    fun `Mocked service - Successful currencies request without currencies`() {
        val service: CurrencyLayerService by unitTestKodein.instance("serviceRequestWithNoCurrencies")
        service.getCurrencies()
            .doOnSuccess {
                // Service response
                assertNotNull(it)
                assertTrue(it.success)

                // Currencies
                assertNotNull(it.currencies)
                assertThat(it.currencies.size, `is`(0))
                assertThat(it.currencies, `is`(notNullValue()))
            }
            .doOnError {
                fail("This test should not get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

    @Test
    fun `Mocked service - Successful conversion rates request`() {
        val service: CurrencyLayerService by unitTestKodein.instance("serviceSuccessfulConversionRatesRequest")
        service.getConversionRates()
            .doOnSuccess {
                // Service response
                assertNotNull(it)
                assertTrue(it.success)

                // Conversion rates
                assertNotNull(it.quotes)
                assertThat(it.quotes.size, greaterThan(0))
            }
            .doOnError {
                fail("This test should not get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

    @Test
    fun `Mocked service - Successful conversion rates request with no conversion rates`() {
        val service: CurrencyLayerService by unitTestKodein.instance("serviceRequestWithNoConversionRates")
        service.getConversionRates()
            .doOnSuccess {
                // Service response
                assertNotNull(it)
                assertTrue(it.success)

                // Currencies
                assertNotNull(it.quotes)
                assertThat(it.quotes.size, `is`(0))
                assertThat(it.quotes, `is`(notNullValue()))
            }
            .doOnError {
                fail("This test should not get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

}
