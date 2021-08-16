package com.br.cambio.data.datasource

import com.br.cambio.data.api.Api
import com.br.cambio.data.model.Currency
import com.br.cambio.domain.model.CurrencyDomain
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import junit.framework.Assert.assertEquals
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runBlockingTest
import org.junit.After
import org.junit.Test
import retrofit2.Response

@ExperimentalCoroutinesApi
class RemoteDataSourceTest {

    private val testDispatcher = TestCoroutineDispatcher()

    private val service: Api = mock()
    private val dataSource: RemoteDataSource = RemoteDataSourceImpl(service)

    @After
    fun tearDown() {
        Dispatchers.resetMain()
        testDispatcher.cleanupTestCoroutines()
    }

    @Test
    fun `list currency should return the list from remote data source`() = runBlockingTest {
        // Given
        whenever(service.getCurrency()).thenReturn(mockResponse())

        // When
        val result = dataSource.getCurrencies()

        // Then
        assertEquals(result, expectedResponse())
        assertEquals(result?.get(0)?.symbol, 12)
    }

    private fun mockResponse() =
        Response.success(
            listOf(
                Currency(
                    key = "BRL",
                    value = "Brazilian Real"
                )
            )
        )

    private fun expectedResponse() =
        listOf(
            CurrencyDomain(
                symbol = "BRL",
                name = "Brazilian Real"
            )
        )
}