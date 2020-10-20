package com.helano.converter.ui.currencies

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.helano.converter.R
import com.helano.converter.adapters.CurrencyAdapter
import com.helano.converter.databinding.FragmentCurrenciesBinding
import com.helano.converter.model.Currency
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrenciesFragment : Fragment() {

    private lateinit var binding: FragmentCurrenciesBinding
    private val viewModel by viewModels<CurrenciesViewModel>()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_currencies, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val list = arrayListOf(
            Currency("USD", "US Dollar"),
            Currency("BRL", "Brazilian Real")
        )

        binding.recycler.apply {
            adapter = CurrencyAdapter(list)
            layoutManager = LinearLayoutManager(context)
        }
    }
}