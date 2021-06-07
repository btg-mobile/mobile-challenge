package br.com.vicentec12.mobilechallengebtg.util

/**
 * Responsável por usar o valor apenas uma vez e limpar a variável LiveData.
 */
class Event<T>(content: T?) {

    private val mContent: T

    var hasBeenHandled = false

    val contentIfNotHandled: T?
        get() {
            if (!hasBeenHandled) {
                hasBeenHandled = true
                return mContent
            }
            return null
        }

    init {
        requireNotNull(content) { "null values in Event are not allowed." }
        mContent = content
    }

}