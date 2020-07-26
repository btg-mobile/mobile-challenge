package com.example.myapplication.features.splash

import android.os.Handler
import com.example.myapplication.R
import com.example.myapplication.core.plataform.BaseActivity
import com.example.myapplication.features.main.MainActivity

class SplashActivity : BaseActivity() {

    override fun setLayout() {
        hideTop(true)
        setContentView(R.layout.activity_splash)
    }

    override fun setObjects() {
        startApp()
    }

    private fun startApp(){
        Handler().postDelayed({
            startActivity(MainActivity::class.java, null)
            finish()
        }, 3000)
    }
}