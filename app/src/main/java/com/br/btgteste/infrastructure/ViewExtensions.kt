package com.br.btgteste.infrastructure

import android.view.View
import androidx.constraintlayout.widget.Group

fun Group.setAllOnClickListener(listener: View.OnClickListener?) {
    referencedIds.forEach { id ->
        rootView.findViewById<View>(id).setOnClickListener(listener)
    }
}

fun View.isVisible(visible: Boolean = false) {
    visibility = if (visible) View.VISIBLE else View.GONE
}