package com.helano.converter.ui.converter

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.Navigation.findNavController
import com.helano.converter.R
import com.helano.converter.databinding.FragmentConverterBinding
import com.helano.converter.model.Conversion
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ConverterFragment : Fragment() {

    private lateinit var binding: FragmentConverterBinding
    private val viewModel by viewModels<ConverterViewModel>()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_converter, container, false
        )
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        binding.viewModel = viewModel
        viewModel.start()
        setClickListeners()
    }

    private fun setClickListeners() {
        binding.fromContainer.setOnClickListener {
            findNavController(it).navigate(
                ConverterFragmentDirections.actionSearchCurrency(
                    Conversion.FROM
                )
            )
        }

        binding.toContainer.setOnClickListener {
            findNavController(it).navigate(
                ConverterFragmentDirections.actionSearchCurrency(
                    Conversion.TO
                )
            )
        }
    }
}