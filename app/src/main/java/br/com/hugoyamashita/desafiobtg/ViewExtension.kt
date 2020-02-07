package br.com.hugoyamashita.desafiobtg

import android.view.View
import android.view.ViewPropertyAnimator
import java.lang.RuntimeException

fun View.fadeIn(duration: Long): ViewPropertyAnimator {
    if (duration < 0) {
        throw RuntimeException("Duration must be non-negative")
    }

    return animate()
        .setDuration(duration)
        .alpha(1f)
}

fun View.fadeOut(duration: Long): ViewPropertyAnimator {
    if (duration < 0) {
        throw RuntimeException("Duration must be non-negative")
    }

    return animate()
        .setDuration(duration)
        .alpha(0f)
}