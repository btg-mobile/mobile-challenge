package com.kaleniuk2.conversordemoedas.ui.activity

import android.os.Bundle
import android.util.Log
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.common.network.NetworkRequestManager
import com.kaleniuk2.conversordemoedas.common.ui.BaseActivity
import com.kaleniuk2.conversordemoedas.common.ui.components.LoadingDialog
import com.kaleniuk2.conversordemoedas.extension.showText
import com.kaleniuk2.conversordemoedas.ui.adapter.ListCurrencyAdapter
import kotlinx.android.synthetic.main.activity_list_currency.*

class ListCurrencyActivity : BaseActivity() {

    private val recyclerCurrency by lazy { findViewById<RecyclerView>(R.id.recycler_currency) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_currency)
        setupRecyclerViewCurrency()
        setupToolbar(toolbar)
    }

    private fun setupRecyclerViewCurrency() {
        NetworkRequestManager{
            Log.i("result", it.toString())
        }.execute("list")

        recyclerCurrency.adapter = ListCurrencyAdapter(listener = {
            showText(it.name)
        })
        recyclerCurrency.layoutManager = LinearLayoutManager(this)
    }
}