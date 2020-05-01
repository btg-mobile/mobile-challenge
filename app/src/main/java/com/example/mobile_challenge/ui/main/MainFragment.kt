package com.example.mobile_challenge.ui.main

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import com.example.mobile_challenge.R
import java.text.DecimalFormat

class MainFragment : Fragment() {

  companion object {
    fun newInstance() = MainFragment()
  }

  private val viewModel: MainViewModel by activityViewModels()
  private lateinit var root: View
  private lateinit var input: EditText
  private lateinit var result: TextView
  private lateinit var fromBtn: Button
  private lateinit var toBtn: Button

  private var currencyValue = 0.0

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View {
    root = inflater.inflate(R.layout.main_fragment, container, false)
    findView()
    clickListeners()
    setInputFormat()
    updateView()
    return root
  }

  private fun findView() {
    input = root.findViewById(R.id.value_input)
    result = root.findViewById(R.id.value_result)
    fromBtn = root.findViewById(R.id.from_currency)
    toBtn = root.findViewById(R.id.to_currency)
  }

  private fun clickListeners() {
    fromBtn.setOnClickListener {
      openSelectionFragment("FROM")
    }

    toBtn.setOnClickListener {
      openSelectionFragment("TO")
    }
  }

  private fun openSelectionFragment(type: String) {
    val bundle = Bundle()
    bundle.putString("TYPE", type)
    if (type == "FROM") {
      bundle.putString("CODE", fromBtn.text.toString())
    } else {
      bundle.putString("CODE", toBtn.text.toString())
    }
    val fragment = SelectionFragment.newInstance()
    fragment.arguments = bundle
    if (activity?.supportFragmentManager?.findFragmentByTag("SelectionFragment") == null) {
      activity?.supportFragmentManager?.beginTransaction()
        ?.replace(R.id.container, fragment)
        ?.addToBackStack("SelectionFragment")
        ?.commit()
    }
  }

  private fun setInputFormat() {
    var current = ""
    input.addTextChangedListener(object : TextWatcher {
      override fun afterTextChanged(s: Editable?) {
        currencyValue.setResult()
      }

      override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

      override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        val stringText = s.toString()
        if (stringText != current) {
          input.removeTextChangedListener(this)
          val cleanString = stringText.replace("[,.]".toRegex(), "")
          val parsed = cleanString.toDouble()
          val formatter = DecimalFormat("###,###.00")
          val formatted = formatter.format(parsed / 100)

          current = formatted
          input.setText(formatted)
          input.setSelection(formatted.length)
          input.addTextChangedListener(this)
        }
      }
    })
  }

  private fun updateView() {
    viewModel.liveValue.observe(viewLifecycleOwner, Observer { value ->
      currencyValue = value
      currencyValue.setResult()
    })

    viewModel.fromCode.observe(viewLifecycleOwner, Observer { code ->
      fromBtn.text = code
    })

    viewModel.toCode.observe(viewLifecycleOwner, Observer { code ->
      toBtn.text = code
    })
  }

  fun Double.setResult() {
    val stringText = input.text.toString()
    val finalResult = if (stringText == "") {
      1000 * this
    } else {
      val cleanString = stringText.replace("[,.]".toRegex(), "")
      val parsed = cleanString.toDouble() / 100
      parsed * this
    }
    val formatter = DecimalFormat("###,###.00")
    result.text = formatter.format(finalResult)
  }
}
