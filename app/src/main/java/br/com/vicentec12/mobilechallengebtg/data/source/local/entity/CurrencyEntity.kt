package br.com.vicentec12.mobilechallengebtg.data.source.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import br.com.vicentec12.mobilechallengebtg.data.model.Currency

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey
    val id: Long,
    val name: String,
    val code: String
) {

    fun toCurrency() = Currency(id, name, code)

}