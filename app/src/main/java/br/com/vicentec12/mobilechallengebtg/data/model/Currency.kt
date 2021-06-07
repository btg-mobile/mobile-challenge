package br.com.vicentec12.mobilechallengebtg.data.model

import android.os.Parcelable
import androidx.recyclerview.widget.DiffUtil
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.CurrencyEntity
import kotlinx.parcelize.Parcelize

@Parcelize
data class Currency(
    val id: Long,
    val name: String,
    val code: String
) : Parcelable {

    fun toCurrencyEntity() = CurrencyEntity(id, name, code)

    companion object {

        val DIFF_UTIL_CALLBACK = object : DiffUtil.ItemCallback<Currency>() {
            override fun areItemsTheSame(oldItem: Currency, newItem: Currency) =
                oldItem.code == newItem.code

            override fun areContentsTheSame(oldItem: Currency, newItem: Currency) =
                oldItem == newItem
        }

    }

}