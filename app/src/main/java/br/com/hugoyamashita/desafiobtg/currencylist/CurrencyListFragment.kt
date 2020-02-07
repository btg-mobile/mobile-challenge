package br.com.hugoyamashita.desafiobtg.currencylist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.hugoyamashita.desafiobtg.R
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListAdapter
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListContract
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListContract.Presenter
import br.com.hugoyamashita.desafiobtg.fadeIn
import br.com.hugoyamashita.desafiobtg.fadeOut
import br.com.hugoyamashita.desafiobtg.model.Currency
import kotlinx.android.synthetic.main.fragment_currencylist.animation_loading
import kotlinx.android.synthetic.main.fragment_currencylist.content
import kotlinx.android.synthetic.main.fragment_currencylist.rv_currencies
import org.kodein.di.Kodein
import org.kodein.di.KodeinAware
import org.kodein.di.android.x.kodein
import org.kodein.di.generic.instance

class CurrencyListFragment : Fragment(), CurrencyListContract.View, KodeinAware {

    companion object {

        private const val FADE_DURATION = 100L

    }

    /**
     * Dependency injector.
     */
    override val kodein: Kodein by kodein()

    /**
     * Presenter reference.
     */
    private val presenter: Presenter by instance()

    private lateinit var currencyListAdapter: RecyclerView.Adapter<*>
    private lateinit var currencyListViewManager: RecyclerView.LayoutManager

    override fun onResume() {
        super.onResume()
        presenter.attachToView(this)
        presenter.loadCurrencyList()
    }

    override fun onPause() {
        super.onPause()
        presenter.detachFromView()
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val root = inflater.inflate(R.layout.fragment_currencylist, container, false)

        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView()
    }

    private fun initView() {
        currencyListAdapter =
            CurrencyListAdapter(
                mutableListOf()
            )
        currencyListViewManager = LinearLayoutManager(this.context)

        rv_currencies.apply {
            setHasFixedSize(true)
            layoutManager = currencyListViewManager
            adapter = currencyListAdapter
        }
    }

    override fun showLoadingAnimation() {
        content.fadeOut(FADE_DURATION)
        animation_loading.fadeIn(FADE_DURATION)
    }

    override fun hideLoadingAnimation() {
        animation_loading.fadeOut(FADE_DURATION)
        content.fadeIn(FADE_DURATION)
    }

    override fun refreshCurrencyList(currencies: List<Currency>) {
        (currencyListAdapter as CurrencyListAdapter).updateItems(currencies)
        currencyListAdapter.notifyDataSetChanged()
    }

}