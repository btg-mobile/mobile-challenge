package com.fernando.currencylist.presentation

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.RecyclerView
import com.fernando.currencylist.R
import com.fernando.currencylist.model.CurrencyViewItem
import com.fernando.currencylist.presentation.adapter.CurrencyListAdapter
import dagger.hilt.android.AndroidEntryPoint


@AndroidEntryPoint
class CurrencyListActivity : AppCompatActivity() {
    private val mainViewModel by viewModels<CurrencyListViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_list_activty)
        setObservable()
        setButtonListener()
    }

    private fun setRecycler(currencyList: List<CurrencyViewItem>) {
        val recycler = findViewById<RecyclerView>(R.id.currencyRecycler)
        val currencyListAdapter = CurrencyListAdapter(currencyList)
        recycler.adapter = currencyListAdapter
    }

    private fun setObservable() {
        mainViewModel.user.observe(this, Observer {
            setRecycler(it)
        })
    }

    private fun setButtonListener() {
        val editText = findViewById<EditText>(R.id.editText)
        val button = findViewById<Button>(R.id.button)

        button.setOnClickListener {
            mainViewModel.searchCurrency(editText.text.toString())
        }
    }
}