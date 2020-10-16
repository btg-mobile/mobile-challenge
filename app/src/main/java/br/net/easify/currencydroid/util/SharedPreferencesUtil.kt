package br.net.easify.currencydroid.util

import android.content.Context
import androidx.preference.PreferenceManager
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class SharedPreferencesUtil @Inject constructor(context: Context) {

    private val prefs =
        PreferenceManager.getDefaultSharedPreferences(context.applicationContext)

    private val lastRateUpdate = "lastRateUpdate"

    fun setLastRateUpdate(value: Long) {
        prefs.edit().putLong(lastRateUpdate, value).apply()
    }

    fun getLastRateUpdate(): Long {
        return if (prefs != null) {
            prefs.getLong(lastRateUpdate, 0)!!
        } else {
            0
        }
    }

    fun removeLastRateUpdate() {
        prefs.edit().remove(lastRateUpdate).apply()
    }
}