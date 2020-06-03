package br.com.mobilechallenge.view

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler

import br.com.mobilechallenge.R
import br.com.mobilechallenge.presenter.splashscreen.Presenter
import br.com.mobilechallenge.presenter.splashscreen.MVP
import br.com.mobilechallenge.utils.UtilsAnimation

class SplashScreen : AppCompatActivity(), MVP.View {
    private val seconds: Long = 2000
    private lateinit var presenter: MVP.Presenter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splashscreen)

        presenter = Presenter()
        presenter.setView(this)
        presenter.retriveData()
    }

    override fun loadData() {
        Handler().postDelayed({
            var intent = Intent(this, MainActivity::class.java)

            startActivity(intent)
            finish()
            UtilsAnimation.leftToRight(this)
        }, seconds)
    }
}