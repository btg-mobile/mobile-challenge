package br.com.leonamalmeida.mobilechallenge.data

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Created by Leo Almeida on 28/06/20.
 */

@Entity
data class Rate(
    @PrimaryKey val code: String,
    val value: Float,
    val lastUpdate: Long
) {
    override fun toString(): String {
        return "$code - $value"
    }
}