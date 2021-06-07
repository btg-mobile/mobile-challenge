package br.com.vicentec12.mobilechallengebtg.data.source.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import br.com.vicentec12.mobilechallengebtg.data.model.Quote

@Entity(tableName = "quote")
data class QuoteEntity(
    @PrimaryKey
    val code: String,
    val source: String,
    val value: Double
) {

    fun toQuote() = Quote(code, source, value)

}