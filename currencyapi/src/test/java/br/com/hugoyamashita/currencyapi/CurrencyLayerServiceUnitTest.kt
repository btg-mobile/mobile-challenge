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
    fun `Mocked service - Successful request with currencies`() {
        val service: CurrencyLayerService by unitTestKodein.instance("serviceSuccessfulRequest")
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
    fun `Mocked service - Successful request without currencies`() {
        val service: CurrencyLayerService by unitTestKodein.instance("noCurrencies")
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

}
