package com.br.mpc.desafiobtg

import android.app.AlertDialog
import android.os.Bundle
import android.util.AttributeSet
import android.view.View
import android.widget.ProgressBar
import androidx.fragment.app.Fragment
import com.br.mpc.desafiobtg.custom.CustomProgress
import com.br.mpc.desafiobtg.repository.State
import com.br.mpc.desafiobtg.ui.MainActivity
import com.br.mpc.desafiobtg.utils.lockScreen
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlin.coroutines.CoroutineContext

abstract class BaseFragment : Fragment(), CoroutineScope {
    private val job = SupervisorJob()
    override val coroutineContext: CoroutineContext = Dispatchers.Main + job
    abstract val viewModel: StateViewModel
    private lateinit var progressScreen: CustomProgress

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        progressScreen = CustomProgress(requireContext())
    }

    override fun onStart() {
        super.onStart()
        viewModel.state.observe(viewLifecycleOwner, { event ->
            val state = event.getContentIfNotHandled() ?: return@observe
            when (state) {
                is State.Loading -> renderLoadingState()
                is State.Success -> renderSuccessState()
                is State.Error -> renderErrorState(state.message)
            }
        })
    }

    private fun renderSuccessState() {
        (requireActivity() as MainActivity).root_view.removeView(progressScreen)
        lockScreen(false)
    }

    private fun renderErrorState(message: String) {
        (requireActivity() as MainActivity).root_view.removeView(progressScreen)
        lockScreen(false)

        val dialog = AlertDialog.Builder(requireContext()).apply {
            setTitle("Falha na requisição")
            setMessage(message)
            setCancelable(false)
        }.create()

        dialog.setButton(AlertDialog.BUTTON_POSITIVE, "Fechar") { _, _ ->
            if (dialog.isShowing) dialog.dismiss()
        }

        dialog.show()
    }

    private fun renderLoadingState() {
        lockScreen(true)
        (requireActivity() as MainActivity).root_view.addView(progressScreen)
    }
}