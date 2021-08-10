package br.com.alanminusculi.btgchallenge.data.local.models

import androidx.room.ColumnInfo
import androidx.room.Entity
import br.com.alanminusculi.btgchallenge.utils.Constants.Companion.USD_PREFIX

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

@Entity
class CurrencyValue(
    id: Int = 0,
    @ColumnInfo val currency: String,
    @ColumnInfo val value: Double
) : BaseModel(id) {

    fun isUsd(): Boolean {
        return currency == USD_PREFIX + USD_PREFIX
    }

    override fun toString(): String {
        return "$currency - $value"
    }

}