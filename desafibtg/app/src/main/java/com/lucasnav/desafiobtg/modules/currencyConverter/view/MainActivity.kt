package com.lucasnav.desafiobtg.modules.currencyConverter.view

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.lucasnav.desafiobtg.R
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


    }


    private fun configClicks() {

//        textFieldCurrencyIWant.setOnClickListener {
//            startActivityForResult(
//                Intent(this@MainActivity, CurrenciesActivity::class.java), )
//        }
    }
}
