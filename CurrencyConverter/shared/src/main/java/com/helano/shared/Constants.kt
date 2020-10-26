package com.helano.shared

object Constants {

    const val BASE_URL = "http://api.currencylayer.com"
    const val API_KEY = "7de50b85198af58fe14d31114c75c86c"
    const val NO_DATA = 0L            // in secs
    const val TIMEOUT_CONNECT = 6L    // in secs
    const val TIMEOUT_READ = 6L       // in secs
    const val TIMEOUT_SPLASH = 2000L  // in millis
    const val TIMEOUT_TO_REFRESH = 10L // in hours
    const val MILLIS_IN_SEC = 1000

    const val DECIMAL_PLACES = "%.3f"

    const val DB_NAME = "currencies.db"
    const val PREFS_NAME = "com.helano.converter.prefs"
}