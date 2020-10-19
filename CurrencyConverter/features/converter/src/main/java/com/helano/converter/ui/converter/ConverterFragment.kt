package com.helano.converter.ui.converter

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.Navigation.findNavController
import com.helano.converter.R
import com.helano.converter.databinding.FragmentConverterBinding
import com.helano.network.repositories.Repository
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.*
import javax.inject.Inject

@AndroidEntryPoint
class ConverterFragment : Fragment() {

    private lateinit var binding: FragmentConverterBinding
    private val viewModel by viewModels<ConverterViewModel>()

    @Inject lateinit var repository: Repository

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_converter, container, false)

        viewModel.text.observe(viewLifecycleOwner, Observer {
            binding.convertedValue.text = it
        })

        setClickListeners()
        return binding.root
    }

    override fun onResume() {
        super.onResume()
        test()
    }

    private fun test() {
//        CoroutineScope(Dispatchers.IO).launch {
//            repository.currencies()
//        }

        GlobalScope.launch(context = Dispatchers.Main) {
            repository.currencies()
            repository.quotes()
        }
    }

    private fun setClickListeners() {
        binding.fromContainer.setOnClickListener {
            findNavController(it).navigate(ConverterFragmentDirections.actionSearchCurrency())
        }

        binding.toContainer.setOnClickListener {
            findNavController(it).navigate(ConverterFragmentDirections.actionSearchCurrency())
        }
    }
}