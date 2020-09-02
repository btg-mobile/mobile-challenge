package com.example.convertermoeda.ui.activity

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.lifecycle.Observer
import com.example.convertermoeda.R
import com.example.convertermoeda.helper.*
import com.example.convertermoeda.provider.providerMainViewModel
import com.example.convertermoeda.ui.viewmodel.state.MainState

class MainActivity : AppCompatActivity() {
    private val viewModel by lazy {
        providerMainViewModel(this)
    }

    private lateinit var btnMoedaOrigem: Button
    private lateinit var btnMoedaDestino: Button
    private lateinit var etMoedaOrigem: EditText
    private lateinit var tvMoedaConvertida: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        title = ""

        bindViews()

        criarObserver()
        configuraEditText(etMoedaOrigem)
    }

    private fun bindViews() {
        btnMoedaOrigem = findViewById(R.id.btn_moeda_origem)
        btnMoedaDestino = findViewById(R.id.btn_moeda_destino)
        etMoedaOrigem = findViewById(R.id.et_moeda_origem)
        tvMoedaConvertida = findViewById(R.id.tv_moeda_convertida)

        btnMoedaOrigem.setOnClickListener { gotToListaDeMoedas(TIPO_GET, ID_ORIGEM, RC_LIST_SOURCE) }
        btnMoedaDestino.setOnClickListener { gotToListaDeMoedas(TIPO_GET, ID_DESTINO, RC_LIST_DESTINY) }
    }

    private fun gotToListaDeMoedas(tipoGet: String, idOrigem: String, rcOrigem: Int) {
        val intent = Intent(this, ListaMoedasActivity::class.java)
        intent.putExtra(tipoGet, idOrigem)
        startActivityForResult(intent, rcOrigem)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == RC_LIST_SOURCE) {
            if (resultCode == Activity.RESULT_OK) {
                btnMoedaOrigem.text = data?.extras?.getString(TIPO_GET_VALUE)
            }
        } else if (requestCode == RC_LIST_DESTINY) {
            if (resultCode == Activity.RESULT_OK) {
                btnMoedaDestino.text = data?.extras?.getString(TIPO_GET_VALUE)
            }
        }
    }

    private fun criarObserver() {
        viewModel.viewState.observe(this, Observer { viewState ->
            viewState?.let {
                when (it) {
                    is MainState.GetCoversao -> showConversao(it.value)
                    is MainState.IsErro -> showError(it.error)
                }
            }
        })

        viewModel.buscarLive(applicationContext)
    }

    private fun showError(error: String) {
        Toast.makeText(this,error,Toast.LENGTH_SHORT).show()
    }

    private fun showConversao(value: Double) {
        tvMoedaConvertida.text = DecimalFormat(value)
    }

    private fun DecimalFormat(number : Double) : String {
        var formated = Math.round(number * 100) / 100.0
        return formated.toString().replace('.',',')
    }

    private fun configuraEditText(etMoedaOrigem: EditText) {
        etMoedaOrigem.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                //empty
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                //empty
            }

            override fun onTextChanged(text: CharSequence?, start: Int, before: Int, count: Int) {
                if (text.toString() != "") {
                    val value = etMoedaOrigem.text.toString()
                    viewModel.getConverter(
                        applicationContext,
                        value.toDouble(),
                        btnMoedaOrigem.text.toString(),
                        btnMoedaDestino.text.toString()
                    )
                } else {
                    tvMoedaConvertida.text = ""
                }
            }

        })
    }
}