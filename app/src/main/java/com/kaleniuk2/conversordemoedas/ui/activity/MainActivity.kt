package com.kaleniuk2.conversordemoedas.ui.activity

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.common.ui.BaseActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseActivity(), View.OnClickListener {
    private val btnCurrencyFrom by lazy { findViewById<Button>(R.id.btn_select_currency_from) }
    private val btnCurrencyTo by lazy { findViewById<Button>(R.id.btn_select_currency_to) }
    private val etSelectValue by lazy { findViewById<EditText>(R.id.et_select_value) }
    private val btnConvert by lazy { findViewById<Button>(R.id.btn_convert) }

    companion object {
        const val FROM = 1
        const val TO = 2
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupListeners()
        setupToolbar(main_toolbar)
    }

    private fun setupListeners() {
        btnConvert.setOnClickListener(this)
        btnCurrencyTo.setOnClickListener(this)
        btnCurrencyFrom.setOnClickListener(this)
    }

    private fun openListCurrency(destination: Int) {
        startActivityForResult(Intent(this, ListCurrencyActivity::class.java), destination)
    }

    private fun convert() {

    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.btn_select_currency_from -> openListCurrency(FROM)
            R.id.btn_select_currency_to -> openListCurrency(TO)
            R.id.btn_convert -> convert()
        }
    }


}