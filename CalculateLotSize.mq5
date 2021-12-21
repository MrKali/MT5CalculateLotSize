//+------------------------------------------------------------------+
//|                                             CalculateLotSize.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property script_show_inputs
#include <Trade\AccountInfo.mqh>
#include <Trade\SymbolInfo.mqh>


CAccountInfo cAccountInfo;
CSymbolInfo cSymbolInfo;

input double risk_percentage = 1; // Percentage of capital to risk per trade
input int sl_in_pips; // Stop Loss in pips
input string in_pair = "EURUSD"; // Currency Pair

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   Alert(CalculateUnitsToTrade());
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetValueToRiskPerTrade()
  {
   string main_currency = StringSubstr(in_pair, 0, 3);
   string counter_currency = StringSubstr(in_pair, 3, 3);
   string account_currency = cAccountInfo.Currency();

   double amount_at_risk_in_account_currency = risk_percentage/100 * cAccountInfo.Balance();
   double amount_at_risk;
   
   if(account_currency == counter_currency)
     {
      amount_at_risk = amount_at_risk_in_account_currency;
     }
   else
      if(account_currency == main_currency)
        {
         double currency_rate = SymbolInfoDouble(in_pair, SYMBOL_ASK);
         amount_at_risk = currency_rate * amount_at_risk_in_account_currency;
        }
      else
         if(SymbolInfoInteger(account_currency + counter_currency, SYMBOL_EXIST))
           {
            string symbol = account_currency + counter_currency;
            double currency_rate = SymbolInfoDouble(symbol, SYMBOL_ASK);
            amount_at_risk = currency_rate * amount_at_risk_in_account_currency;

           }
         else
            if(SymbolInfoInteger(counter_currency + account_currency, SYMBOL_EXIST))
              {
               string symbol = counter_currency + account_currency;
               double currency_rate = SymbolInfoDouble(symbol, SYMBOL_ASK);
               amount_at_risk = (1/currency_rate) * amount_at_risk_in_account_currency;
              }

   return NormalizeDouble(amount_at_risk, 2);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetValuePerPip()
  {
   return NormalizeDouble(GetValueToRiskPerTrade()/sl_in_pips, 2);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CalculateUnitsToTrade()
  {
   return GetValuePerPip() * 10000;
  }

// 1 -> Obter qual a moeda da conta
//+------------------------------------------------------------------+
