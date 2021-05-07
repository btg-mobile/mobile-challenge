package com.geocdias.convecurrency.ui.fragments

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.NavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.geocdias.convecurrency.R
import com.geocdias.convecurrency.databinding.CurrencyListLayoutBinding
import com.geocdias.convecurrency.databinding.FragmentCurrencyListBinding
import com.geocdias.convecurrency.ui.adapters.CurrencyListAdapter
import com.geocdias.convecurrency.ui.viewmodel.CurrencyViewModel
import com.geocdias.convecurrency.util.Resource
import com.geocdias.convecurrency.util.Status
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrencyListFragment : Fragment() {
    private var fragBiding: FragmentCurrencyListBinding? = null
    private var currencyListLayoutBinding: CurrencyListLayoutBinding? = null
    private val viewModel: CurrencyViewModel by viewModels()
    private lateinit var navController: NavController
    private val currencyListAdapter: CurrencyListAdapter by lazy {
        CurrencyListAdapter()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding = FragmentCurrencyListBinding.inflate(inflater, container, false)
        currencyListLayoutBinding = CurrencyListLayoutBinding.bind(binding.root)
        fragBiding = binding

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupUI()
        setupObservers()
    }

    private fun setupUI() {
        currencyListLayoutBinding?.currenciesRv?.apply {
            adapter = currencyListAdapter
            layoutManager = LinearLayoutManager(context)
            setHasFixedSize(true)
        }

        currencyListLayoutBinding?.searchCurrencyEt?.addTextChangedListener(object: TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

            override fun onTextChanged(charSequence: CharSequence?, p1: Int, p2: Int, p3: Int) {
                currencyListAdapter.filter.filter(charSequence)
            }

            override fun afterTextChanged(p0: Editable?) {}
        })
    }

    private fun setupObservers() {
        viewModel.currencies.observe(viewLifecycleOwner, Observer {
            when (it.status) {
                Status.SUCCESS -> {
                    showProgress(false)
                    if (!it.data.isNullOrEmpty()) currencyListAdapter.currencyList = it.data
                }
                Status.ERROR ->
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_SHORT).show()

                Status.LOADING ->
                   showProgress(true)
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        fragBiding = null
        currencyListLayoutBinding = null
    }

    private fun showProgress(show: Boolean) {
        if (show) {
            currencyListLayoutBinding?.progress?.visibility = View.VISIBLE
        } else {
            currencyListLayoutBinding?.progress?.visibility = View.GONE
        }
    }
}
