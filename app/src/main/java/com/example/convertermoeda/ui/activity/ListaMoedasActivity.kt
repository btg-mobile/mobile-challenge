package com.example.convertermoeda.ui.activity

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.View.GONE
import android.view.View.VISIBLE
import android.widget.EditText
import android.widget.ProgressBar
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.convertermoeda.R
import com.example.convertermoeda.helper.TIPO_GET_VALUE
import com.example.convertermoeda.model.Currencies
import com.example.convertermoeda.provider.providerListaMoedasViewModel
import com.example.convertermoeda.ui.adapter.ListModedasAdapter
import com.example.convertermoeda.ui.viewmodel.state.ListaMoedasState

class ListaMoedasActivity : AppCompatActivity() {
    private val viewModel by lazy {
        providerListaMoedasViewModel(this)
    }

    private val adapter by lazy {
        ListModedasAdapter(viewModel)
    }

    private lateinit var etBuscar: EditText
    private lateinit var recyclerView: RecyclerView
    private lateinit var progressBar: ProgressBar
    private lateinit var layoutManager: LinearLayoutManager

    private var listMoedas: ArrayList<Currencies> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_lista_moedas)

        bindViews()
        criarObserver()
        configurarRecyclerView()
        configuraEditText(etBuscar)
    }

    private fun bindViews() {
        etBuscar = findViewById(R.id.et_buscar)
        recyclerView = findViewById(R.id.rv_list_moedas)
        progressBar = findViewById(R.id.progressBar)
    }

    private fun criarObserver() {
        viewModel.viewState.observe(this, Observer { viewState ->
            viewState?.let {
                when (it) {
                    is ListaMoedasState.ShowListsMoedas -> adapter.atualiza(it.lista)
                    is ListaMoedasState.MoedaEscolihda -> moedaEscolhida(it.item)
                    is ListaMoedasState.ShowLoading -> showLoagind()
                    is ListaMoedasState.HideLoading -> hideLoading()
                    is ListaMoedasState.IsErro -> {
                        Log.e("error", "erro ao buscar lista das moedas ${it.error}")
                    }
                }
            }
        })

        viewModel.getLocalListaMoedas(applicationContext)
        viewModel.getListaMoedas(applicationContext)
    }

    private fun showLoagind() {
        progressBar.visibility = VISIBLE
    }

    private fun hideLoading() {
        progressBar.visibility = GONE
    }

    private fun configurarRecyclerView() {
        layoutManager = LinearLayoutManager(this)
        recyclerView.layoutManager = layoutManager
        recyclerView.adapter = adapter
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
                    listMoedas.clear()
                    for (item in viewModel.getList()) {
                        if (item.code.toLowerCase().contains(text.toString().toLowerCase()) ||
                            item.nome.toLowerCase().contains(text.toString().toLowerCase())
                        ) {
                            listMoedas.add(item)
                        }
                    }

                    listMoedas.sortBy { it.nome }
                    adapter.atualiza(listMoedas)

                } else {
                    adapter.atualiza(viewModel.getList())
                }
            }

        })
    }

    private fun moedaEscolhida(code: Currencies) {
        val data = Intent()
        data.putExtra(TIPO_GET_VALUE, code.code)
        setResult(Activity.RESULT_OK, data)
        finish()
    }
}