package com.natanbf.currencyconversion.util

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

abstract class BaseViewModel<State, Event> : ViewModel() {

    abstract val initialState: State
    val currentState: State get() = uiState.value

    private val _uiState: MutableStateFlow<State> by lazy { MutableStateFlow(initialState) }
    val uiState: StateFlow<State> get() = _uiState.asStateFlow()

    private val _event: MutableSharedFlow<Event> by lazy { MutableSharedFlow() }
    val event: SharedFlow<Event> get() = _event.asSharedFlow()

    init {
        viewModelScope.launch {
            event.collect {
                handleEvent(it)
            }
        }
    }

    protected abstract fun handleEvent(event: Event)

    fun sendEvent(event: Event) = viewModelScope.launch {
        _event.emit(event)
    }

    protected fun updateUiState(reduce: State.() -> State) {
        _uiState.value = currentState.reduce()
    }

}