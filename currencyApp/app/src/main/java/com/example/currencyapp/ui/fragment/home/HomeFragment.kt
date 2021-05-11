package com.example.currencyapp.ui.fragment.home

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.lifecycle.Observer
import com.example.currencyapp.R
import com.example.currencyapp.database.dao.CurrencyDao
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.databinding.FragmentHomeBinding
import com.example.currencyapp.network.service.CurrencyList
import com.example.currencyapp.network.service.CurrencyRate
import com.example.currencyapp.repository.HomeRepository
import com.google.android.material.snackbar.Snackbar
import org.koin.android.ext.android.inject
import org.koin.android.viewmodel.ext.android.viewModel

class HomeFragment : Fragment() {

    private val homeViewModel : HomeViewModel by viewModel()
    private var binding : FragmentHomeBinding ?= null
    private var arrayAdapter : ArrayAdapter<String> ?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentHomeBinding.inflate(inflater, container, false)


        context ?: return binding?.root
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observerCurrencyOutput()
        initObserver()
    }

    private fun initObserver() {
        homeViewModel.getCurrencies().observe(viewLifecycleOwner, Observer {
            it?.let {
                println("List in page ")
                observerCurrencyList()
            }?: println("Empty List")
        })
    }

    private fun observerCurrencyOutput() {
        homeViewModel.convertedCurrency.observe(viewLifecycleOwner, Observer {
            binding?.outputTextView?.text = it.toString()
        })
    }

    private fun observerCurrencyList() {
        homeViewModel.getCurrenciesInitials().observe(viewLifecycleOwner, Observer {
            it?.let {
                arrayAdapter = ArrayAdapter(requireContext(), android.R.layout.simple_list_item_1, it)
                binding?.bySpinner?.adapter = arrayAdapter
            }?:println("Empty data")
        })
    }

    private fun observerError() {
       homeViewModel.error.observe(viewLifecycleOwner, Observer {
           val snackbar: Snackbar = Snackbar.make(requireView(), it, Snackbar.LENGTH_SHORT)

           snackbar.setAction("OK") {
               snackbar.dismiss()
           }

           snackbar.show()
       })
    }
}