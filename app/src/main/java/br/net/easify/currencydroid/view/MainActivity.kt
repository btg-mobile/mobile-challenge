package br.net.easify.currencydroid.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import br.net.easify.currencydroid.R

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //delegate.localNightMode = AppCompatDelegate.MODE_NIGHT_YES;
    }
}