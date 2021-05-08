package com.example.currencyapp.ui.fragment.currencyList

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.Observer
import com.example.currencyapp.R
import com.example.currencyapp.databinding.FragmentCurrencyListBinding
import com.example.currencyapp.ui.fragment.currencyList.adapter.CurrencyListAdapter
import com.google.android.material.snackbar.Snackbar
import org.koin.android.viewmodel.ext.android.viewModel

class CurrencyListFragment : Fragment() {

    private val listViewModel : CurrencyListViewModel by viewModel()
    private var binding : FragmentCurrencyListBinding?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCurrencyListBinding.inflate(inflater, container, false)

        context ?: return binding?.root
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observerError()
        observerList()
    }

    private fun observerList() {
        listViewModel.getCurrencyList().observe(viewLifecycleOwner, Observer { currencies ->
            currencies.let {
                println("DATA $it")
//                val adapter = CurrencyListAdapter(currencies = it)
//                binding?.currenciesList?.adapter = adapter
            }
        })
    }

    private fun observerError() {
        listViewModel.error.observe(viewLifecycleOwner, Observer {
            val snackbar: Snackbar = Snackbar.make(requireView(), it, Snackbar.LENGTH_SHORT)

            snackbar.setAction("OK") {
                snackbar.dismiss()
            }

            snackbar.show()
        })
    }
}