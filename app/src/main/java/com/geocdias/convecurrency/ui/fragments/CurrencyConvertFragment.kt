package com.geocdias.convecurrency.ui.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.geocdias.convecurrency.databinding.FragmentCurrencyConvertBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrencyConvertFragment : Fragment() {
   private var fragBiding: FragmentCurrencyConvertBinding? = null

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
    }
}
