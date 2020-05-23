package com.btg.converter.presentation.util.error

import com.btg.converter.domain.entity.error.ErrorData
import com.btg.converter.domain.entity.error.HttpError
import com.btg.converter.domain.entity.error.RequestException
import com.btg.converter.domain.util.resource.Strings
import com.btg.converter.presentation.util.dialog.DialogData
import com.btg.converter.presentation.util.logger.Logger

class ErrorHandler constructor(
    private val strings: Strings,
    private val logger: Logger
) {

    fun getDialogData(
        throwable: Throwable,
        retryAction: (() -> Unit)?
    ): DialogData {
        val data = getErrorData(throwable, retryAction)
        return data.tryAgainAction?.let {
            DialogData.error(strings, data.message, strings.globalTryAgain, it)
        } ?: DialogData.error(strings, data.message, strings.globalOk)
    }

    private fun getErrorData(
        throwable: Throwable,
        tryAgainAction: (() -> Unit)? = null
    ): ErrorData {
        logger.e(throwable)
        return if (throwable is RequestException) {
            handleRequestException(throwable, tryAgainAction)
        } else {
            ErrorData.UnexpectedErrorData(strings.errorUnknown, tryAgainAction)
        }
    }

    private fun handleRequestException(
        exception: RequestException,
        tryAgainAction: (() -> Unit)? = null
    ): ErrorData {
        return when {
            exception.isUnProcessableEntity() ->
                ErrorData.UnProcessableEntityErrorData(
                    exception.errorMessage ?: strings.errorUnknown
                )
            exception.isTimeOutException() ->
                ErrorData.TimeOutErrorData(strings.errorSocketTimeout, tryAgainAction)
            exception.isNetworkError() -> ErrorData.NetworkErrorData(
                strings.errorNetwork,
                tryAgainAction
            )
            exception.isUnauthorizedError() -> ErrorData.UnauthorizedErrorData(
                exception.errorMessage ?: strings.errorUnknown
            )
            exception.isHttpError() -> resolveHttpError(exception, tryAgainAction)
            else -> ErrorData.UnexpectedErrorData(strings.errorUnknown, tryAgainAction)
        }
    }

    private fun resolveHttpError(
        exception: RequestException,
        tryAgainAction: (() -> Unit)?
    ): ErrorData {
        return when (HttpError.getErrorForCode(exception.errorCode)) {
            HttpError.NOT_FOUND -> ErrorData.NotFoundErrorData(
                exception.errorMessage ?: strings.errorNotFound
            )
            HttpError.TIMEOUT -> ErrorData.TimeOutErrorData(
                strings.errorSocketTimeout,
                tryAgainAction
            )
            HttpError.INTERNAL_SERVER_ERROR -> ErrorData.HttpErrorData(
                strings.errorUnknown,
                tryAgainAction
            )
            else -> ErrorData.HttpErrorData(
                exception.errorMessage
                    ?: exception.message
                    ?: strings.errorUnknown,
                null
            )
        }
    }
}
