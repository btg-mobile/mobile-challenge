/**
 * Kotlin extension allowing the access of view elements inside activity class without using
 * only its template id as variable name, bypassing findViewById()
 */
package com.leonardo.convertcoins.config

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes


fun ViewGroup.inflate(@LayoutRes layoutRes: Int, attachToRoot: Boolean = false): View {
    return LayoutInflater.from(context).inflate(layoutRes, this, attachToRoot)
}
