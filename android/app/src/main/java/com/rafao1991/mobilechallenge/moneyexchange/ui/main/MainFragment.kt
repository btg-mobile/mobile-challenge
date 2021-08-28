package com.rafao1991.mobilechallenge.moneyexchange.ui.main

import android.opengl.Visibility
import androidx.lifecycle.ViewModelProvider
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.Observer
import androidx.navigation.findNavController
import com.rafao1991.mobilechallenge.moneyexchange.R
import com.rafao1991.mobilechallenge.moneyexchange.domain.ApiStatus
import com.rafao1991.mobilechallenge.moneyexchange.domain.Currency
import java.math.RoundingMode
import java.text.DecimalFormat

class MainFragment : Fragment() {

    private lateinit var viewModel: MainViewModel

    private lateinit var constraintLayoutMain: ConstraintLayout
    private lateinit var textViewErrorMessage: TextView
    private lateinit var textViewLoadingMessage: TextView
    private lateinit var buttonOriginCurrency: Button
    private lateinit var buttonTargetCurrency: Button
    private lateinit var editTextTextAmount: EditText
    private lateinit var textViewResult: TextView

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return inflater.inflate(R.layout.fragment_main, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProvider(requireActivity()).get(MainViewModel::class.java)
        activity?.let {
            loadViews(it)
            loadActions()
            setObservables()
        }
    }

    private fun loadViews(fragmentActivity: FragmentActivity) {
        constraintLayoutMain = fragmentActivity.findViewById(R.id.constraintLayoutMain)
        textViewErrorMessage = fragmentActivity.findViewById(R.id.textViewErrorMessage)
        textViewLoadingMessage = fragmentActivity.findViewById(R.id.textViewLoadingMessage)

        buttonOriginCurrency = fragmentActivity.findViewById(R.id.buttonOriginCurrency)
        buttonTargetCurrency = fragmentActivity.findViewById(R.id.buttonTargetCurrency)
        editTextTextAmount = fragmentActivity.findViewById(R.id.editTextTextAmount)
        textViewResult = fragmentActivity.findViewById(R.id.textViewResult)
    }

    private fun loadActions() {
        buttonOriginCurrency.setOnClickListener {
            it.findNavController().navigate(
                MainFragmentDirections
                    .actionMainFragmentToCurrencyListFragment(Currency.ORIGIN))
        }

        buttonTargetCurrency.setOnClickListener {
            it.findNavController().navigate(
                MainFragmentDirections
                    .actionMainFragmentToCurrencyListFragment(Currency.TARGET))
        }

        editTextTextAmount.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {}

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                viewModel.handleExchange(s.toString())
            }
        })
    }

    private fun setObservables() {
        viewModel.status.observe(viewLifecycleOwner, {
            it?.let {
                when(it) {
                    ApiStatus.LOADING -> {
                        constraintLayoutMain.visibility = View.GONE
                        textViewErrorMessage.visibility = View.GONE
                        textViewLoadingMessage.visibility = View.VISIBLE
                    }
                    ApiStatus.DONE -> {
                        constraintLayoutMain.visibility = View.VISIBLE
                        textViewErrorMessage.visibility = View.GONE
                        textViewLoadingMessage.visibility = View.GONE
                    }
                    ApiStatus.ERROR -> {
                        constraintLayoutMain.visibility = View.GONE
                        textViewErrorMessage.visibility = View.VISIBLE
                        textViewLoadingMessage.visibility = View.GONE
                    }
                }
            }
        })

        viewModel.originCurrency.observe(viewLifecycleOwner, {
            buttonOriginCurrency.text = it
        })

        viewModel.targetCurrency.observe(viewLifecycleOwner, {
            buttonTargetCurrency.text = it
        })

        viewModel.result.observe(viewLifecycleOwner, {
            val df = DecimalFormat("#.##")
            df.roundingMode = RoundingMode.CEILING
            textViewResult.text = df.format(it)
        })
    }
}