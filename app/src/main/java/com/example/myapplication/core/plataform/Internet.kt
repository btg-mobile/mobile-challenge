package com.example.myapplication.core.plataform

import android.content.Context
import android.net.ConnectivityManager

class Internet {

    @Suppress("DEPRECATION")
    fun isInternetAvailable(context: Context): Boolean {
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networkInfo = cm.activeNetworkInfo
        return networkInfo != null && networkInfo.isConnected
    }
}