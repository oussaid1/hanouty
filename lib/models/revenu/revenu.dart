import 'package:hanouty/models/Sale/sales_calculations.dart';
import 'package:hanouty/models/recharge/recharge_sales_calculations.dart';

import '../debt/debt.dart';
import '../expenses/expenses.dart';
import '../income/income.dart';
import '../recharge/recharge_sales_data.dart';

class Revenu {
  SaleCalculations? salesData;
  ExpenseData? expensesData;
  DebtData? debtData;
  IncomeData? incomeData;
  RechargeSalesData? rechargeSalesData;
  Revenu({
    this.salesData,
    this.expensesData,
    this.debtData,
    this.incomeData,
    this.rechargeSalesData,
  });

  // double get total revenue with expenses and debt and income
  double get totalRevenue {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (expensesData != null) {
      total -= expensesData!.totalUnPaidExpensesAmount;
    }
    if (debtData != null) {
      total -= debtData!.totalDebtAmountLeft;
    }
    if (incomeData != null) {
      total += incomeData!.totalIncomeAmount;
    }
    if (rechargeSalesData != null) {
      total +=
          rechargeSalesData!.rechargeSalesCalculations.totalRechargeNetProfit;
    }
    return total;
  }

  // double get total revenue with expenses and debts
  double get totalRevenueWithExpensesAndDebt {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (expensesData != null) {
      total -= expensesData!.totalUnPaidExpensesAmount;
    }
    if (debtData != null) {
      total -= debtData!.totalDebtAmountLeft;
    }
    return total;
  }

  // double get total revenue with expenses and income
  double get totalRevenueWithExpensesAndIncome {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (expensesData != null) {
      total -= expensesData!.totalUnPaidExpensesAmount;
    }
    if (incomeData != null) {
      total += incomeData!.totalIncomeAmount;
    }
    return total;
  }

  // double get total revenue with debt and income
  double get totalRevenueWithDebtAndIncome {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (debtData != null) {
      total -= debtData!.totalDebtAmountLeft;
    }
    if (incomeData != null) {
      total += incomeData!.totalIncomeAmount;
    }
    return total;
  }

  // double get total revenue with debt
  double get totalRevenueWithDebt {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (debtData != null) {
      total -= debtData!.totalDebtAmountLeft;
    }
    return total;
  }

  // double get total revenue with expenses
  double get totalRevenueWithExpenses {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (expensesData != null) {
      total -= expensesData!.totalUnPaidExpensesAmount;
    }
    return total;
  }

  // double get total revenue with income
  double get totalRevenueWithIncome {
    double total = 0.0;

    if (salesData != null) {
      total += salesData!.totalNetProfit;
    }
    if (incomeData != null) {
      total += incomeData!.totalIncomeAmount;
    }
    return total;
  }
}
