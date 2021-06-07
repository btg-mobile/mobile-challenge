package br.com.vicentec12.mobilechallengebtg.ui.currencies

import androidx.recyclerview.widget.RecyclerView
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.databinding.ItemCurrencyBinding
import br.com.vicentec12.mobilechallengebtg.interfaces.OnItemClickListener

class CurrenciesHolder(
    private val mBinding: ItemCurrencyBinding,
    private val mOnItemClickListener: OnItemClickListener?
) : RecyclerView.ViewHolder(mBinding.root) {

    fun bind(mCurrency: Currency) {
        mBinding.currency = mCurrency
        mOnItemClickListener?.let {
            itemView.setOnClickListener {
                mOnItemClickListener.onItemClick(itemView, mCurrency, adapterPosition)
            }
        }
    }

}