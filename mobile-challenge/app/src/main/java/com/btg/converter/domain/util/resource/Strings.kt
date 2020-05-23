package com.btg.converter.domain.util.resource

import android.content.Context
import androidx.annotation.StringRes
import com.btg.converter.R

class Strings constructor(private val context: Context) {

    val errorTitle: String get() = res(R.string.error_title)
    val errorUnknown: String get() = res(R.string.error_unknown)
    val errorNetwork: String get() = res(R.string.error_network)
    val errorUnprocessable: String get() = res(R.string.error_unprocessable)
    val errorUnauthorizedLoginNow: String get() = res(R.string.error_unauthorized_login_now)
    val errorNotFound: String get() = res(R.string.error_not_found)
    val errorNotProcessable: String get() = res(R.string.error_not_processable)
    val errorSocketTimeout: String get() = res(R.string.error_socket_timeout)
    val globalYes: String get() = res(R.string.global_yes)
    val globalNo: String get() = res(R.string.global_no)
    val globalWarning: String get() = res(R.string.global_warning)
    val globalFacebook: String get() = res(R.string.global_facebook)
    val globalGoogle: String get() = res(R.string.global_google)
    val globalOr: String get() = res(R.string.global_or)
    val globalWait: String get() = res(R.string.global_wait)
    val globalTryAgain: String get() = res(R.string.global_try_again)
    val globalCancel: String get() = res(R.string.global_cancel)
    val globalDoLogin: String get() = res(R.string.global_do_login)
    val globalOk: String get() = res(R.string.global_ok)

    private fun res(@StringRes stringId: Int) = context.getString(stringId)
}