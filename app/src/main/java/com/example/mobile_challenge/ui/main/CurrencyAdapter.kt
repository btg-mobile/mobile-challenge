package com.example.mobile_challenge.ui.main

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.example.mobile_challenge.R
import com.example.mobile_challenge.model.Currency

interface OnItemClickListener{
  fun onItemClicked(item: Currency)
}

class CurrencyAdapter(private var items: ArrayList<Currency>, var clickResponse : OnItemClickListener) :
  RecyclerView.Adapter<CurrencyAdapter.UserViewHolder>(), Filterable {

  var filterItems = items

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
    val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency_list, parent, false)
    return UserViewHolder(view)
  }

  override fun getItemCount(): Int {
    return filterItems.size
  }

  fun setItemsAdapter(newList: ArrayList<Currency>) {
    val oldList = filterItems
    val diffCallback = PostDiffCallback(oldList, newList)
    val diffResult = DiffUtil.calculateDiff(diffCallback)
    filterItems = newList
    if (items.isEmpty()) {
      items = newList
    }
    diffResult.dispatchUpdatesTo(this)
  }

  fun getItem(position: Int): Currency {
    return filterItems[position]
  }

  fun removeAt(position: Int) {
    filterItems.removeAt(position)
    notifyItemRemoved(position)
    notifyItemRangeChanged(position, filterItems.size)
  }

  fun restoreItem(post: Currency, position: Int) {
    filterItems.add(position, post)
    notifyItemInserted(position)
  }

  override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
    val item = filterItems[position]
    holder.currencyTextView.text = "${item.currencyCode} - ${item.currencyName}"
    holder.currencyTextView.setOnClickListener {
      clickResponse.onItemClicked(item)
    }
  }

  class UserViewHolder(view: View) : RecyclerView.ViewHolder(view) {
    var currencyTextView: TextView = view.findViewById(R.id.currency_text) as TextView
  }

  class PostDiffCallback(
    private val oldList: List<Currency>,
    private val newList: List<Currency>
  ) : DiffUtil.Callback() {

    override fun getOldListSize(): Int {
      return oldList.size
    }

    override fun getNewListSize(): Int {
      return newList.size
    }

    override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
      return oldList[oldItemPosition].currencyName == newList[newItemPosition].currencyName
    }

    override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
      return oldList[oldItemPosition].equals(newList[newItemPosition])
    }
  }

  override fun getFilter(): Filter {
    return object : Filter() {
      override fun publishResults(charSequence: CharSequence?, filterResults: FilterResults) {
        filterItems = filterResults.values as ArrayList<Currency>
        notifyDataSetChanged()
      }

      override fun performFiltering(charSequence: CharSequence?): FilterResults {
        val keyWords = charSequence?.toString()?.toLowerCase()
        val filterResults = FilterResults()
        val suggestions = if (keyWords == null || keyWords.isEmpty())
          items
        else {
          items.filter {
            it.currencyCode.toLowerCase().contains(keyWords) ||
                it.currencyName.toLowerCase().contains(keyWords)
          }
        }
        filterResults.values = suggestions
        filterResults.count = suggestions.count()
        return filterResults
      }
    }
  }
}