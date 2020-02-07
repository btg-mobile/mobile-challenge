package br.com.hugoyamashita.desafiobtg.converter

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.fragment.app.Fragment
import br.com.hugoyamashita.desafiobtg.R
import br.com.hugoyamashita.desafiobtg.converter.CurrencyConverterContract.Presenter
import br.com.hugoyamashita.desafiobtg.fadeIn
import br.com.hugoyamashita.desafiobtg.fadeOut
import br.com.hugoyamashita.desafiobtg.model.Currency
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.fragment_converter.btn_convert
import kotlinx.android.synthetic.main.fragment_converter.content
import kotlinx.android.synthetic.main.fragment_converter.edt_converted_value
import kotlinx.android.synthetic.main.fragment_converter.edt_value
import kotlinx.android.synthetic.main.fragment_converter.rootView
import kotlinx.android.synthetic.main.fragment_converter.spn_from_currency
import kotlinx.android.synthetic.main.fragment_converter.spn_to_currency
import kotlinx.android.synthetic.main.fragment_currencylist.animation_loading
import org.kodein.di.Kodein
import org.kodein.di.KodeinAware
import org.kodein.di.android.x.kodein
import org.kodein.di.generic.instance
import java.math.RoundingMode.HALF_UP

class CurrencyConverterFragment : Fragment(), CurrencyConverterContract.View, KodeinAware {

    companion object {

        private const val FADE_DURATION = 100L
        private const val PRECISION = 2

    }

    /**
     * Dependency injector.
     */
    override val kodein: Kodein by kodein()

    /**
     * Presenter reference.
     */
    private val presenter: Presenter by instance()

    private lateinit var adapter: ArrayAdapter<Currency>

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
        val root = inflater.inflate(R.layout.fragment_converter, container, false)

        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView()
    }

    private fun initView() {
        adapter = CurrencyArrayAdapter(this.context!!, android.R.layout.simple_spinner_dropdown_item, mutableListOf())
        spn_from_currency.adapter = adapter
        spn_to_currency.adapter = adapter

        btn_convert.setOnClickListener {
            if (edt_value.text!!.isEmpty()) {
                showSnackBar("Valor original obrigatório")
            } else {
                presenter.calculateConvertedValue(
                    edt_value.text.toString().toDouble(),
                    (spn_from_currency.selectedItem as Currency).symbol,
                    (spn_to_currency.selectedItem as Currency).symbol
                )
            }
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
        adapter.clear()
        adapter.addAll(currencies)
        adapter.notifyDataSetChanged()
    }

    override fun updateCalculatedValue(value: Double) {
        edt_converted_value.setText(value.toBigDecimal().setScale(PRECISION, HALF_UP).toString())
    }

    private fun showSnackBar(message: String) {
        Snackbar.make(rootView, message, Snackbar.LENGTH_SHORT).show()
    }

}