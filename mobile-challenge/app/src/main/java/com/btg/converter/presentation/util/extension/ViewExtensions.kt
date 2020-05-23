package com.btg.converter.presentation.util.extension

import android.view.View
import com.btg.converter.presentation.util.click.SafeClickListener

fun View.setSafeClickListener(callback: () -> Unit) {
    val intervalInMillis = 1000
    SafeClickListener(callback, intervalInMillis).apply {
        setOnClickListener(this::onClick)
    }
}