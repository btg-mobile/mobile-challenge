package com.btg.converter.presentation.util.extension

import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.EditText
import com.btg.converter.presentation.util.click.SafeClickListener

fun View.setSafeClickListener(callback: () -> Unit) {
    val intervalInMillis = 1000
    SafeClickListener(callback, intervalInMillis).apply {
        setOnClickListener(this::onClick)
    }
}

fun EditText.onTextChanges(callback: (String) -> Unit) {
    addTextChangedListener(object : TextWatcher {
        override fun afterTextChanged(p0: Editable?) {}

        override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

        override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            callback(p0.toString())
        }
    })
}