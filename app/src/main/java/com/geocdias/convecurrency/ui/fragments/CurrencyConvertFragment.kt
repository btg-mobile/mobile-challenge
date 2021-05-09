package com.geocdias.convecurrency.ui.fragments

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.icu.util.CurrencyAmount
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.*
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

        fragBiding?.convertBtn?.setOnClickListener {
            val currencyFrom = fragBiding?.convertFromBtn?.text.toString()
            val currencyTo = fragBiding?.convertToBtn?.text.toString()
            val amount = fragBiding?.amountEdt?.text.toString()

            convertCurrency(currencyFrom, currencyTo, amount)
        }
    }

    private fun convertCurrency(currencyFrom: String, currencyTo: String, amount: String) {
        viewModel.convert(currencyFrom, currencyTo, amount).observe(viewLifecycleOwner, { resource ->
            when(resource.status) {
                Status.LOADING -> fragBiding?.convertProgress?.visibility = View.VISIBLE
                Status.SUCCESS -> {
                    fragBiding?.convertProgress?.visibility = View.GONE
                    fragBiding?.amountConverted?.text = resource.data.toString()
                }
                Status.ERROR -> {
                    fragBiding?.convertProgress?.visibility = View.GONE
                    Toast.makeText(context, resource.message, Toast.LENGTH_SHORT).show()
                }
            }
        })

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
        val spinnerBinding = CurrencySpinnerBinding.inflate(layoutInflater)
        val dialog = Dialog(requireContext()).apply {
            setContentView(spinnerBinding.root)
            setCanceledOnTouchOutside(true)
            show()
        }

        viewModel.currencyList.observe(viewLifecycleOwner,{ resource ->
            when(resource.status){
                Status.LOADING ->  spinnerBinding.spnListProgress.visibility = View.VISIBLE
                Status.SUCCESS -> {
                    spinnerBinding.spnListProgress.visibility = View.GONE
                    resource.data?.let {
                        currencyListAdapter.currencyList = it
                    }
                }
                Status.ERROR -> {
                    spinnerBinding.spnListProgress.visibility = View.GONE
                    spinnerBinding.errorTxt.visibility = View.VISIBLE
                    spinnerBinding.errorTxt.text = resource.message
                }
            }
        })

        spinnerBinding.spnCurrenciesRv.apply {
            adapter = currencyListAdapter
            layoutManager = LinearLayoutManager(context)
            setHasFixedSize(true)
        }

        currencyListAdapter.setOnClickListener { currency ->
            spinnerFn.invoke(currency.code)
            dialog.hide()
        }

        spinnerBinding.spnSearchCurrencyEt.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

            override fun onTextChanged(charSequence: CharSequence?, p1: Int, p2: Int, p3: Int) {
                currencyListAdapter.filter.filter(charSequence)
            }

            override fun afterTextChanged(p0: Editable?) {}
        })
    }

//    private fun closeSoftKeyboard(context: Context, v: View) {
//        val iMm = context.getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
//        iMm.hideSoftInputFromWindow(v.windowToken, 0)
//        v.clearFocus()
//    }

}
