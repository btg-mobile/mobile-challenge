package com.example.exchange.fragment

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.View
import android.widget.ArrayAdapter
import androidx.lifecycle.ViewModelProviders
import com.example.exchange.R
import com.example.exchange.databinding.FragmentConverterBinding
import com.example.exchange.viewmodel.ConverterViewModel

class ConverterFragment : Fragment(R.layout.fragment_converter) {

    private lateinit var viewModel: ConverterViewModel
    private lateinit var binding: FragmentConverterBinding

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = FragmentConverterBinding.bind(view)

        viewModel = ViewModelProviders.of(this).get(ConverterViewModel::class.java)

        initObservers()
        initListeners()

        viewModel.requestData()
    }

    private fun initObservers() {
        viewModel.getData().observe(viewLifecycleOwner, {
            val listSpinner = ArrayAdapter(requireContext(), R.layout.spinner_item, it)

            with(binding) {
                spinnerCoinOne.adapter = listSpinner
                spinnerCoinTwo.adapter = listSpinner
            }
        })

        viewModel.getLoading().observe(viewLifecycleOwner, {
            binding.progressbarConverter.visibility = it
        })

        viewModel.getError().observe(viewLifecycleOwner, {
            // TODO include dialog error
        })
    }

    private fun initListeners() {

    }
}