package com.picpay.desafio.android.data.repository

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.picpay.desafio.android.data.datasource.RemoteDataSource
import com.picpay.desafio.android.domain.model.UserDomain
import com.picpay.desafio.android.domain.repository.PicPayRepository
import com.picpay.desafio.android.presentation.mapper.PicPayPresentation
import junit.framework.Assert.assertEquals
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Test

@ExperimentalCoroutinesApi
class PicPayRepositoryTest {

    private val dataSource: RemoteDataSource = mock()

    private val repository: PicPayRepository by lazy {
        PicPayRepositoryImpl(dataSource)
    }

    @Test
    fun `When get users from remote data source should return success`() = runBlockingTest {
        // Given
        whenever(dataSource.getUsers()).thenReturn(mockResponse())

        // When
        val result = repository.getUsers()

        // Then
        val data = result as PicPayPresentation.SuccessResponse
        assertEquals(data.items[0].id, 12)
    }

    @Test
    fun `When get users from remote data source should return failure`() = runBlockingTest {
        // Given
        whenever(dataSource.getUsers()).thenReturn(null)

        // When
        val result = repository.getUsers()

        // Then
        assertEquals(result, PicPayPresentation.ErrorResponse)
    }

    @Test
    fun `When get users from remote data source should return empty list`() =
        runBlockingTest {
            // Given
            whenever(dataSource.getUsers()).thenReturn(mockEmptyResponse())

            // When
            val result = repository.getUsers()

            // Then
            assertEquals(result, PicPayPresentation.EmptyResponse)
        }

    private fun mockResponse() =
        listOf(
            UserDomain(
                id = 12,
                name = "teste",
                username = "teste",
                img = "teste"
            )
        )

    private fun mockEmptyResponse() = emptyList<UserDomain>()
}