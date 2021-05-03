package com.leonardo.convertcoins.config

class Keys {

    init {
        System.loadLibrary("native-lib")
    }

    external fun apiKey(): String
}