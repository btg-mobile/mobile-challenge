package com.example.exchange.fragment

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.exchange.R
import com.example.exchange.databinding.FragmentCoinBinding
import com.example.exchange.utils.CoinAdapter
import com.example.exchange.viewmodel.CoinViewModel

class CoinFragment : Fragment(R.layout.fragment_coin) {

    private lateinit var viewModel: CoinViewModel

    private lateinit var binding: FragmentCoinBinding

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = FragmentCoinBinding.bind(view)

        viewModel = ViewModelProviders.of(this).get(CoinViewModel::class.java)

        initObservers()

        viewModel.requestData()
    }

    private fun initObservers() {
        viewModel.getData().observe(viewLifecycleOwner, {
            with(binding.recyclerviewCoin) {
                adapter = CoinAdapter(it)
                layoutManager = LinearLayoutManager(context)
            }
        })
    }
}