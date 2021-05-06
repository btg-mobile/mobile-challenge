package com.geocdias.convecurrency.ui.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.geocdias.convecurrency.databinding.CurrencyListItemBinding
import com.geocdias.convecurrency.model.CurrencyModel

class CurrencyListAdapter(): RecyclerView.Adapter<CurrencyListAdapter.CurrencyViewHolder>() {

    class CurrencyViewHolder(val binding: CurrencyListItemBinding): RecyclerView.ViewHolder(binding.root)

    var diffCallback = object: DiffUtil.ItemCallback<CurrencyModel>() {
        override fun areItemsTheSame(oldItem: CurrencyModel, newItem: CurrencyModel): Boolean {
            return oldItem.code == newItem.code
        }

        override fun areContentsTheSame(oldItem: CurrencyModel, newItem: CurrencyModel): Boolean {
            return oldItem.hashCode() == newItem.hashCode()
        }
    }

    val differ: AsyncListDiffer<CurrencyModel> = AsyncListDiffer(this, diffCallback)

    var currencyList: List<CurrencyModel>
        get() = differ.currentList
        set(list) = differ.submitList(list)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyListAdapter.CurrencyViewHolder {
        return CurrencyViewHolder(
            CurrencyListItemBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CurrencyListAdapter.CurrencyViewHolder, position: Int) {
        val currency = currencyList[position]
        holder.binding.currencyCode.text = currency.code
        holder.binding.currencyName.text = currency.name
    }

    override fun getItemCount(): Int = currencyList.count()
}
