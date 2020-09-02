package com.example.convertermoeda.ui.viewmodel.state

import com.example.convertermoeda.model.Currencies

sealed class ListaMoedasState {
    data class ShowListsMoedas(val lista: List<Currencies>) : ListaMoedasState()
    data class MoedaEscolihda(val item: Currencies) : ListaMoedasState()
    data class IsErro(val error: String) : ListaMoedasState()
    object ShowLoading : ListaMoedasState()
    object HideLoading : ListaMoedasState()
}

sealed class ListaMoedasInteracao {
    data class ItemClicado(val item: Currencies) : ListaMoedasInteracao()
}