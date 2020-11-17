package com.br.mpc.desafiobtg.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.br.mpc.desafiobtg.BaseFragment
import com.br.mpc.desafiobtg.R
import com.br.mpc.desafiobtg.utils.*
import kotlinx.android.synthetic.main.fragment_main.*
import org.koin.androidx.viewmodel.ext.android.sharedViewModel

class MainFragment : BaseFragment() {
    override val viewModel by sharedViewModel<MainViewModel>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_main, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupListeners()
    }

    override fun onPause() {
        super.onPause()
        viewModel.amount = conversionValueTextInput.editText!!.text.toString()
    }

    override fun onResume() {
        super.onResume()
        conversionValueTextInput.editText!!.setText(viewModel.amount)
    }

    private fun setupListeners() {
        inputButton.setOnClickListener {
            navigate(MainFragmentDirections.actionMainFragmentToSecondaryFragment(INPUT_CURRENCY_TYPE))
        }

        outputButton.setOnClickListener {
            navigate(MainFragmentDirections.actionMainFragmentToSecondaryFragment(OUTPUT_CURRENCY_TYPE))
        }

        conversionValueTextInput.setEndIconOnClickListener {
            conversionValueTextInput.editText?.setText("0,00")
        }

        conversionValueTextInput.editText!!.addTextChangedListener(MonetaryMask(conversionValueTextInput.editText!!))

        convertButton.setOnClickListener {
            val amount = conversionValueTextInput.editText?.text.toString().replace(".", "").replace(",", ".").toDoubleOrNull()
            if (amount != null) viewModel.convertCurrency(amount)
            else Toast.makeText(requireContext(), "Digite um valor válido", Toast.LENGTH_SHORT).show()
        }

        changeCurrenciesImage.setOnClickListener {
            viewModel.changeCurrencies()
        }
    }

    private fun subscribe() {
        with(viewModel) {
            inputCurrency.observe(viewLifecycleOwner) {
                if (it != null) {
                    convertButton.isEnabled = outputCurrency.value != null
                    inputDescription.text = "Entrada: ${it.split(" - ")[1]}"
                    inputButton.text = it.split(" - ")[0]
                } else {
                    convertButton.isEnabled = false
                    inputDescription.text = "Entrada"
                    inputButton.text = "XXX"
                }
            }

            outputCurrency.observe(viewLifecycleOwner) {
                if (it != null) {
                    convertButton.isEnabled = inputCurrency.value != null
                    outputDescription.text = "Saída: ${it.split(" - ")[1]}"
                    outputButton.text = it.split(" - ")[0]
                } else {
                    convertButton.isEnabled = false
                    inputDescription.text = "Saída"
                    inputButton.text = "XXX"
                }
            }

            convertedAmount.observe(viewLifecycleOwner) {
                outputTextView.text = it.format()
            }
        }
    }

    override fun onStart() {
        super.onStart()
        subscribe()
    }
}