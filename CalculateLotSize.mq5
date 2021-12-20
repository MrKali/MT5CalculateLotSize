//+------------------------------------------------------------------+
//|                                             CalculateLotSize.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\AccountInfo.mqh>

CAccountInfo cAccountInfo;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   Alert(cAccountInfo.Balance());
  }
//+------------------------------------------------------------------+