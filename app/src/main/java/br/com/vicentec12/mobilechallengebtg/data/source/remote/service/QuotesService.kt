package br.com.vicentec12.mobilechallengebtg.data.source.remote.service

import br.com.vicentec12.mobilechallengebtg.data.source.remote.dto.QuotesDto
import retrofit2.Response
import retrofit2.http.GET

interface QuotesService {

    @GET("/live")
    suspend fun live(): Response<QuotesDto>

}