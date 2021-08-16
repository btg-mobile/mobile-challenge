package com.picpay.desafio.android.data.mapper

import com.picpay.desafio.android.data.model.User
import com.picpay.desafio.android.domain.model.UserDomain
import org.junit.Test
import kotlin.test.assertEquals

class UserDomainMapperTest {

    private val mapper: UserToDomainMapper = UserToDomainMapper()

    @Test
    fun `when mapper should map to presentation`() {
        // When
        val result = mapper.map(mockResponse())

        // Then
        assertEquals(listOf(result), mockExpected())
    }

    private fun mockResponse() =
            User(
                id = 12,
                name = "teste",
                username = "teste",
                img = "teste"
            )

    private fun mockExpected() =
        listOf(
            UserDomain(
                id = 12,
                name = "teste",
                username = "teste",
                img = "teste"
            )
        )
}