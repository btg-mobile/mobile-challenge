package com.helano.shared.util

import android.content.Context
import androidx.core.content.edit
import com.helano.shared.Constants
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class Preferences @Inject constructor(@ApplicationContext context: Context) {
    private val prefs = context.getSharedPreferences(Constants.PREFS_NAME, Context.MODE_PRIVATE)

    fun setFromCurrencyCode(code: String) {
        prefs.edit { putString(FROM_CURRENCY_CODE, code) }
    }

    fun getFromCurrencyCode(): String {
        return getCurrencyCode(FROM_CURRENCY_CODE, FROM_CURRENCY_CODE_DEFAULT)
    }

    fun setToCurrencyCode(code: String) {
        prefs.edit { putString(FROM_CURRENCY_CODE, code) }
    }

    fun getToCurrencyCode(): String {
        return getCurrencyCode(TO_CURRENCY_CODE, TO_CURRENCY_CODE_DEFAULT)
    }

    private fun getCurrencyCode(code: String, defaultCode: String): String {
        val currency = prefs.getString(code, "")
        return if (currency.isNullOrEmpty()) {
            prefs.edit { putString(code, defaultCode) }
            defaultCode
        } else {
            currency
        }
    }

    companion object {
        private const val FROM_CURRENCY_CODE_DEFAULT = "USD"
        private const val TO_CURRENCY_CODE_DEFAULT = "BRL"
        private const val FROM_CURRENCY_CODE = "from_currency_code"
        private const val TO_CURRENCY_CODE = "to_currency_code"
    }
}