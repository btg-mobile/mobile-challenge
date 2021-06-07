package br.com.vicentec12.mobilechallengebtg.data.source.remote.service

import br.com.vicentec12.mobilechallengebtg.data.source.remote.dto.CurrenciesDto
import br.com.vicentec12.mobilechallengebtg.data.source.remote.dto.QuotesDto
import retrofit2.Response
import retrofit2.http.GET

interface CurrenciesService {

    @GET("/list")
    suspend fun list(): Response<CurrenciesDto>

}