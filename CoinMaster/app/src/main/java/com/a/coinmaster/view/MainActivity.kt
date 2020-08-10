package com.a.coinmaster.view

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.a.coinmaster.MainApplication
import com.a.coinmaster.R
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        MainApplication.getComponent()?.inject(this)
        btCoinSource.setOnClickListener {
            val intent = Intent(this, CoinListActivity::class.java)
            startActivityForResult(intent, CHOOSE_COIN_SOURCE_REQUEST_CODE)
        }
    }

    companion object {
        const val CHOOSE_COIN_SOURCE_REQUEST_CODE = 100
    }
}