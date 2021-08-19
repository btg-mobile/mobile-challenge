package com.example.challengesavio

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.challengesavio.adapters.CurrenciesListAdapter
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.databinding.ActivityListCurrenciesActivityBinding

class ListCurrenciesActivity : AppCompatActivity() {
    private lateinit var currenciesAdapter: CurrenciesListAdapter
    private var currencyList = ArrayList<Currency>()
    private lateinit var mLayoutManager: LinearLayoutManager
    private lateinit var binding: ActivityListCurrenciesActivityBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_list_currencies_activity)
        binding.lifecycleOwner = this
        binding.executePendingBindings()

        initRecyclerView()
        searchCurrencies()

    }

    private fun searchCurrencies() {
        binding.run {
            searchCurrencies.addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) = Unit

                override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                    currenciesAdapter.filter.filter(p0)
                }

                override fun afterTextChanged(p0: Editable?) = Unit

            })
        }
    }

    private fun initRecyclerView() {
        currencyList= MyApplication.database?.currencyDao()?.getAllCurrencies() as ArrayList<Currency>

        mLayoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        binding.recyclerView.layoutManager = mLayoutManager
        currenciesAdapter = CurrenciesListAdapter(currencyList)
        binding.recyclerView.adapter = currenciesAdapter
    }
}