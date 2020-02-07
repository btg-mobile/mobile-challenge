package br.com.hugoyamashita.currencyapi

import br.com.hugoyamashita.currencyapi.di.unitTestKodein
import br.com.hugoyamashita.currencyapi.exception.CurrencyApiException
import org.hamcrest.CoreMatchers.`is`
import org.hamcrest.CoreMatchers.notNullValue
import org.hamcrest.CoreMatchers.nullValue
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Assert.assertNotNull
import org.junit.Assert.fail
import org.junit.Test
import org.kodein.di.generic.instance
import java.lang.Exception

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class CurrencyLayerApiUnitTest {

    @Test
    fun `List should have 3 currencies`() {
        val api: CurrencyLayerApi by unitTestKodein.instance("apiWithFixed3Currencies")

        api.getCurrencyList()
            .doOnSuccess {
                assertThat(it, `is`(notNullValue()))
                assertThat(it.size, `is`(3))
            }
            .doOnError {
                fail("This test should never get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

    @Test
    fun `Error handling while requesting currency list`() {
        val api: CurrencyLayerApi by unitTestKodein.instance("apiWithCurrencyRequestError")

        api.getCurrencyList()
            .doOnSuccess {
                fail("This test must not get here")
            }
            .doOnError {
                assertThat(it, `is`(notNullValue()))
            }
            .test()
            .assertNotComplete()
            .assertError(CurrencyApiException::class.java)
    }

    @Test
    fun `List should have 2 conversion rates`() {
        val api: CurrencyLayerApi by unitTestKodein.instance("apiWithFixed2ConversionRates")

        api.getConversionRateList()
            .doOnSuccess {
                assertThat(it, `is`(notNullValue()))
                assertThat(it.size, `is`(2))
            }
            .doOnError {
                fail("This test should never get here")
            }
            .test()
            .assertComplete()
            .assertNoErrors()
    }

    @Test
    fun `Error handling while requesting conversion rate list`() {
        val api: CurrencyLayerApi by unitTestKodein.instance("apiWithConversionRateRequestError")

        api.getCurrencyList()
            .doOnSuccess {
                fail("This test must not get here")
            }
            .doOnError {
                assertThat(it, `is`(notNullValue()))
            }
            .test()
            .assertNotComplete()
            .assertError(CurrencyApiException::class.java)
    }

}
