package br.com.vicentec12.mobilechallengebtg.data.model

import android.os.Parcelable
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.QuoteEntity
import kotlinx.parcelize.Parcelize

@Parcelize
data class Quote(
    val code: String,
    val source: String,
    val value: Double
) : Parcelable {

    fun toQuoteEntity() = QuoteEntity(code, source, value)

}