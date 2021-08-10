package br.com.alanminusculi.btgchallenge.utils

import java.lang.Exception
import java.text.DecimalFormat

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class Formatting {

    private val decimal = DecimalFormat("#,###,###,##0.00")

    fun toString(value: Double): String {
        return try {
            decimal.format(value)
        } catch (exception: Exception) {
            decimal.format(0.0)
        }
    }

    fun toDouble(value: String): Double {
        return try {
            decimal.parse(value).toDouble()
        } catch (exception: Exception) {
            0.0
        }
    }
}