package com.geocdias.convecurrency.ui.fragments

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.geocdias.convecurrency.databinding.CurrencyListLayoutBinding
import com.geocdias.convecurrency.databinding.CurrencySpinnerBinding
import com.geocdias.convecurrency.ui.adapters.CurrencyListAdapter
import com.geocdias.convecurrency.ui.viewmodel.CurrencyViewModel
import com.geocdias.convecurrency.util.Status
import dagger.hilt.android.AndroidEntryPoint
import java.util.*

@AndroidEntryPoint
class CurrenciesDialogFragment: DialogFragment() {
    private var spinnerBiding: CurrencySpinnerBinding? = null
    private var currencyListLayoutBinding: CurrencyListLayoutBinding? = null
    private val currencyListAdapter: CurrencyListAdapter by lazy {
        CurrencyListAdapter()
    }
    private val viewModel: CurrencyViewModel by viewModels()

    interface CurrenciesDialogListener {
        fun onCurrencySelected(inputText: String?)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding = CurrencySpinnerBinding.inflate(inflater, container, false)
        currencyListLayoutBinding = CurrencyListLayoutBinding.bind(binding.root)
        spinnerBiding = binding
        Objects.requireNonNull(dialog)?.window?.setLayout(650, 800)
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupUI()
        setupObservers()
        sendCurrencyResult("BRL")
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
        viewModel.currencies.observe(viewLifecycleOwner, {
            when (it.status) {
                Status.SUCCESS -> {
                    currencyListLayoutBinding?.progress?.visibility = View.GONE
                    if (!it.data.isNullOrEmpty()) currencyListAdapter.currencyList = it.data
                }
                Status.ERROR ->
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_SHORT).show()

                Status.LOADING ->
                    currencyListLayoutBinding?.progress?.visibility = View.VISIBLE
            }
        })
    }

    override fun onDestroy() {
        spinnerBiding = null
        currencyListLayoutBinding = null
        super.onDestroy()
    }

    fun sendCurrencyResult(currency: String) {
        val listener = parentFragmentManager.findFragmentByTag(tag)?.let {
          it as CurrenciesDialogListener
        }

        listener?.onCurrencySelected(currency)

    }
}
