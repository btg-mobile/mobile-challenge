package com.br.mpc.desafiobtg.utils

import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.EditText

class MonetaryMask(private val field: EditText) : TextWatcher {
    private var isUpdating = false

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        if (isUpdating) {
            isUpdating = false
            return
        }
        isUpdating = true
        var amount = s.toString()
        amount = amount.replace(",", "").replace(".", "")
        try {
            amount = (amount.toDouble() /100).format()
            field.setText(amount)
            field.setSelection(field.text.length)
        } catch (e: NumberFormatException) {
        }
    }

    override fun afterTextChanged(s: Editable?) {}
}
