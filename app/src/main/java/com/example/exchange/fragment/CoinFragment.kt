package com.example.exchange.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.exchange.R
import com.example.exchange.utils.CoinAdapter
import com.example.exchange.viewmodel.CoinViewModel
import kotlinx.android.synthetic.main.fragment_coin.*

class CoinFragment : Fragment() {

    private lateinit var viewModel: CoinViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_coin, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProviders.of(this).get(CoinViewModel::class.java)

        initObservers()

        viewModel.requestData()
    }

    private fun initObservers() {
        viewModel.getData().observe(this, {
            with(recyclerview_coin) {
                adapter = CoinAdapter(it)
                layoutManager = LinearLayoutManager(context)
            }
        })
    }
}