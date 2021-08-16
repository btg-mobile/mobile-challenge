package com.picpay.desafio.android.domain

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.picpay.desafio.android.domain.repository.PicPayRepository
import com.picpay.desafio.android.domain.usecase.GetUsersUseCase
import com.picpay.desafio.android.presentation.mapper.PicPayPresentation
import com.picpay.desafio.android.presentation.model.UserPresentation
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Test
import kotlin.test.assertEquals

@ExperimentalCoroutinesApi
class GetUsersUseCaseTest {

    private val repository: PicPayRepository = mock()
    private val useCase: GetUsersUseCase = GetUsersUseCase(repository)

    @Test
    fun `when invoke should return list`() = runBlockingTest {
        // Given
        whenever(repository.getUsers()).thenReturn(mockResponse())

        // When
        val result = useCase.invoke()

        // Then
        assertEquals(result, mockResponse())
    }

    @Test
    fun `when invoke should return empty list`() = runBlockingTest {
        // Given
        whenever(repository.getUsers()).thenReturn(mockEmptyResponse())

        // When
        val result = useCase.invoke()

        // Then
        assertEquals(result, PicPayPresentation.EmptyResponse)
    }

    @Test
    fun `when invoke should return throwable`() = runBlockingTest {
        // Given
        whenever(repository.getUsers()).thenReturn(PicPayPresentation.ErrorResponse)

        // When
        val result = useCase.invoke()

        // Then
        assertEquals(result, PicPayPresentation.ErrorResponse)
    }

    private fun mockResponse() =
        PicPayPresentation.SuccessResponse(
            listOf(
                UserPresentation(
                    id = 12,
                    name = "teste",
                    username = "teste",
                    img = "teste"
                )
            )
        )

    private fun mockEmptyResponse() = PicPayPresentation.EmptyResponse
}