package com.helano.converter.ui.currencies

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.Navigation.findNavController
import androidx.navigation.fragment.navArgs
import com.helano.converter.R
import com.helano.converter.adapters.CurrenciesAdapter
import com.helano.converter.databinding.FragmentCurrenciesBinding
import com.helano.shared.view.ErrorMessageView
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrenciesFragment : Fragment() {

    private lateinit var binding: FragmentCurrenciesBinding
    private lateinit var adapter: CurrenciesAdapter
    private val viewModel by viewModels<CurrenciesViewModel>()
    private val args: CurrenciesFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_currencies, container, false
        )
        binding.viewModel = viewModel
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        binding.lifecycleOwner = viewLifecycleOwner
        viewModel.start()
        setAdapter()
        setNavigation()
        ErrorMessageView(binding.listContainer, viewLifecycleOwner)
    }

    private fun setAdapter() {
        val viewModel = binding.viewModel
        if (viewModel != null) {
            adapter = CurrenciesAdapter(viewModel)
            binding.recycler.adapter = adapter
        } else {
            Log.e(TAG, "ViewModel not initialized.")
        }
    }

    private fun setNavigation() {
        viewModel.selectedCurrency.observe(viewLifecycleOwner, Observer<String> {
            findNavController(binding.recycler).navigate(
                CurrenciesFragmentDirections.actionFoundCurrency(args.info, it)
            )
        })
    }

    companion object {
        val TAG = CurrenciesFragment::class.simpleName
    }
}