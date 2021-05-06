package com.example.currencyapp.ui.fragment.home

import org.junit.Assert.*
import org.junit.Test

class HomeViewModelTest {
    val homeViewModel = HomeViewModel()

    @Test
    fun `Teste se a conversao retorna valores`() {
        val result = homeViewModel.convertCurrencyAtoCurrencyB(input = 500,
                currencyAToUSDTaxes = 5.441196, currencyUSDToBTaxes = 1)

        println(result)
        assertEquals(result, 91.82, 0.1)
    }

    @Test
    fun `Teste se a conversao com input 0 retorna valores`() {
        val result = homeViewModel.convertCurrencyAtoCurrencyB(input = 0,
                currencyAToUSDTaxes = 5.441196, currencyUSDToBTaxes = 1.22885)

        println(result)
        assertEquals(result, 0.0, 0.1)
    }

    @Test
    fun `Teste se a conversao de 500 reais para dolar canadense tem resultado proximo a 112`() {
        val result = homeViewModel.convertCurrencyAtoCurrencyB(input = 500,
                currencyAToUSDTaxes = 5.441196, currencyUSDToBTaxes = 1.22885)

        println(result)
        assertEquals(result, 112.0, 0.1)
    }

    @Test
    fun `Teste se a conversao de 1000 CAD para real tem resultado proximo a 4437,02`() {
        val result = homeViewModel.convertCurrencyAtoCurrencyB(input = 1000,
                currencyAToUSDTaxes = 1.22885, currencyUSDToBTaxes = 5.441196)

        println(result)
        assertEquals(result, 4427.87, 0.1)
    }

    @Test
    fun `Teste se algum dos valors eh nao numero`(){

    }

    @Test
    fun `Teste se a conversao retorna erro caso um dos campos seja nulo ou vazio`() {

    }


}