package com.lucasnav.desafiobtg.modules.currencyConverter.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.util.CURRENCY_INPUT
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_HAVE_CURRENCY
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_WANT_CURRENCY
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        configClicks()
    }

    private fun configClicks() {

        textCurrencyIWant.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_WANT_CURRENCY
            )
        }

        textCurrencyIHave.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_HAVE_CURRENCY
            )
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            SELECT_I_WANT_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    textCurrencyIWant.setText(data?.getStringExtra(CURRENCY_INPUT))
                }
            }
            SELECT_I_HAVE_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    textCurrencyIHave.setText(data?.getStringExtra(CURRENCY_INPUT))
                }
            }
        }
    }
}
