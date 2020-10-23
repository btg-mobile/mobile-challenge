package com.helano.shared.util.network.core

import android.util.Log

internal inline fun <T> T.safeRun(TAG: String = "", block: T.() -> Unit) {
    try {
        block()
    } catch (e: Throwable) {
        Log.e(TAG, e.toString())
    }
}