package br.com.vicentec12.mobilechallengebtg.ui.currencies

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.databinding.ItemCurrencyBinding
import br.com.vicentec12.mobilechallengebtg.interfaces.OnItemClickListener

class CurrenciesAdapter(
    private val mOnItemClickListener: OnItemClickListener?
) : ListAdapter<Currency, CurrenciesHolder>(Currency.DIFF_UTIL_CALLBACK) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = CurrenciesHolder(
        ItemCurrencyBinding.inflate(LayoutInflater.from(parent.context), parent, false),
        mOnItemClickListener
    )

    override fun onBindViewHolder(holder: CurrenciesHolder, position: Int) {
        holder.bind(currentList[position])
    }

    override fun getItemId(position: Int) = currentList[position].id

}