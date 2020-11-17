package com.br.mpc.desafiobtg

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.br.mpc.desafiobtg.repository.State
import com.br.mpc.desafiobtg.utils.Event
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Response

abstract class StateViewModel: ViewModel() {
    private val _state = MutableLiveData<Event<State>>()
    val state: LiveData<Event<State>> get() = _state

    protected suspend fun <T> doRequest(
        call: suspend () -> Response<T>,
        onSuccess: (T) -> Unit
    ) {
        try {
            _state.postValue(Event(State.Loading))
            val response = withContext(Dispatchers.IO) { call() }
            if (response.isSuccessful) {
                if (response.body() != null) withContext(Dispatchers.Main) {
                    _state.postValue(Event(State.Success))
                    onSuccess(response.body()!!)
                } else {
                    _state.postValue(Event(State.Error(response.message())))
                }
            } else {
                _state.postValue(Event(State.Error("Não foi possível carregar as informações")))
            }
        } catch (e: Exception) {
            _state.postValue(Event(State.Error("Não foi possível carregar as informações")))
        }
    }
}