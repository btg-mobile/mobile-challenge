package com.example.convertermoeda.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.example.convertermoeda.R
import com.example.convertermoeda.model.Currencies
import com.example.convertermoeda.ui.viewmodel.ListaMoedasViewModel
import com.example.convertermoeda.ui.viewmodel.state.ListaMoedasInteracao

class ListModedasAdapter(
    private val viewModel: ListaMoedasViewModel,
    private val listaRepositorios: MutableList<Currencies> = mutableListOf()
) : RecyclerView.Adapter<ListModedasAdapter.ListModedasViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListModedasViewHolder {
        val inflate = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_lista_moedas, parent, false)
        return ListModedasViewHolder(inflate)
    }

    override fun getItemCount() = listaRepositorios.size

    override fun onBindViewHolder(holder: ListModedasViewHolder, position: Int) {
        holder.bindView(listaRepositorios[position], viewModel)
    }

    fun atualiza(item: List<Currencies>) {
        notifyItemRangeRemoved(0, this.listaRepositorios.size)
        this.listaRepositorios.clear()
        this.listaRepositorios.addAll(item)
        notifyItemRangeInserted(0, this.listaRepositorios.size)
    }

    class ListModedasViewHolder(item: View) : RecyclerView.ViewHolder(item) {

        val listItem: CardView = item.findViewById(R.id.cv_moeda)
        val moeda: TextView = item.findViewById(R.id.tv_nome_moeda)
        val code: TextView = item.findViewById(R.id.tv_code_moeda)

        fun bindView(item: Currencies, viewModel: ListaMoedasViewModel) {

            listItem.setOnClickListener {
                viewModel.interactor(ListaMoedasInteracao.ItemClicado(item))
            }

            moeda.text = item.nome
            code.text = item.code
        }

    }
}

