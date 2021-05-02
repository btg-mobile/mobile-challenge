package com.leonardo.convert_coins

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.leonardo.convert_coins.utils.Api

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        println("Sout")
        val api = Api()
    }
}