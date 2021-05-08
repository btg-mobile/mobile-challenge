package com.geocdias.convecurrency.ui.fragments

import android.app.Dialog
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.EditText
import android.widget.ProgressBar
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.geocdias.convecurrency.R
import com.geocdias.convecurrency.databinding.CurrencyListLayoutBinding
import com.geocdias.convecurrency.databinding.CurrencySpinnerBinding
import com.geocdias.convecurrency.databinding.FragmentCurrencyConvertBinding
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.ui.adapters.CurrencyListAdapter
import com.geocdias.convecurrency.ui.viewmodel.CurrencyConverterViewModel
import com.geocdias.convecurrency.util.Status
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrencyConvertFragment : Fragment() {
    private var fragBiding: FragmentCurrencyConvertBinding? = null
    private val currencyListAdapter: CurrencyListAdapter by lazy {
        CurrencyListAdapter()
    }
    private val viewModel: CurrencyConverterViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val binding = FragmentCurrencyConvertBinding.inflate(inflater, container, false)
        fragBiding = binding

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupUI()
    }

    private fun setupUI() {
        fragBiding?.convertFromBtn?.setOnClickListener {
            openFromCurrencyDialog()
        }

        fragBiding?.convertToBtn?.setOnClickListener {
            openToCurrencyDialog()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        fragBiding = null
    }

    private fun openFromCurrencyDialog() {
       openDialog { code ->
           fragBiding?.convertFromBtn?.text = code
       }
    }

    private fun openToCurrencyDialog() {
        openDialog { code ->
            fragBiding?.convertToBtn?.text = code
        }
    }

    private fun openDialog(spinnerFn:(value: String) -> Unit) {

        val dialog = Dialog(requireContext())
        dialog.setContentView(R.layout.currency_spinner)
        dialog.show()

        val searchEditText = dialog.findViewById<EditText>(R.id.searchCurrencyEt)
        val currenciesRv = dialog.findViewById<RecyclerView>(R.id.currenciesRv)
        val progress = dialog.findViewById<ProgressBar>(R.id.currencyListProgress)
        val errorTxt = dialog.findViewById<TextView>(R.id.errorTxt)

        viewModel.currencyList.observe(viewLifecycleOwner,{ resource ->
            when(resource.status){
                Status.LOADING -> progress.visibility = View.VISIBLE
                Status.SUCCESS -> {
                    progress.visibility = View.GONE
                    resource.data?.let {
                        currencyListAdapter.currencyList = it
                    }
                }
                Status.ERROR -> {
                    progress.visibility = View.GONE
                    errorTxt.visibility = View.VISIBLE
                    errorTxt.text = resource.message
                }
            }
        })

        currenciesRv.apply {
            adapter = currencyListAdapter
            layoutManager = LinearLayoutManager(context)
            setHasFixedSize(true)
        }

        currencyListAdapter.setOnClickListener { currency ->
            spinnerFn.invoke(currency.code)
            dialog.hide()
        }

        searchEditText.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

            override fun onTextChanged(charSequence: CharSequence?, p1: Int, p2: Int, p3: Int) {
                currencyListAdapter.filter.filter(charSequence)
            }

            override fun afterTextChanged(p0: Editable?) {}
        })
    }
}
