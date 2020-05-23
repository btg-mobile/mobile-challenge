package com.btg.converter.presentation.util.logger

import android.content.Context
import android.util.Log
import com.btg.converter.BuildConfig
import com.btg.converter.R

class Logger constructor(context: Context) {

    private val tag = context.getString(R.string.app_name)

    fun v(message: String) {
        if (BuildConfig.DEBUG) Log.v(tag, message)
    }

    fun v(message: String, tr: Throwable) {
        if (BuildConfig.DEBUG) Log.v(tag, message, tr)
    }

    fun d(message: String) {
        if (BuildConfig.DEBUG) Log.d(tag, message)
    }

    fun d(message: String, tr: Throwable) {
        if (BuildConfig.DEBUG) Log.d(tag, message, tr)
    }

    fun i(message: String) {
        if (BuildConfig.DEBUG) Log.i(tag, message)
    }

    fun i(message: String, tr: Throwable) {
        if (BuildConfig.DEBUG) Log.i(tag, message, tr)
    }

    fun w(message: String) {
        if (BuildConfig.DEBUG) Log.w(tag, message)
    }

    fun w(message: String, tr: Throwable) {
        if (BuildConfig.DEBUG) Log.w(tag, message, tr)
    }

    fun w(tr: Throwable) {
        if (BuildConfig.DEBUG) Log.w(tag, tr.message, tr)
    }

    fun e(message: String) {
        if (BuildConfig.DEBUG) Log.e(tag, message)
    }

    fun e(message: String, tr: Throwable) {
        if (BuildConfig.DEBUG) Log.e(tag, message, tr)
    }

    fun e(tr: Throwable) {
        if (BuildConfig.DEBUG) Log.e(tag, tr.message, tr)
    }
}
