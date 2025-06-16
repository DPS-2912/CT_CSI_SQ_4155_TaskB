# CT_CSI_SQ_4155_TaskB  
## AdventureWorks SQL Assignment

This repository contains a comprehensive set of stored procedures, functions, views, and triggers built on the **AdventureWorks 2019** database. It demonstrates practical SQL Server usage, including inventory checks, order management, and business rule enforcement.

---

## 📘 Overview

This project includes the following:

- ✅ 4 Stored Procedures  
- ✅ 2 Scalar Functions  
- ✅ 3 Views  
- ✅ 2 Triggers  

All scripts are written in **T-SQL** and assume that the **AdventureWorks2019** sample database is installed and configured on Microsoft SQL Server.

---

## 🧾 SQL Script Descriptions

**sql1.sql** – *InsertOrderDetails*  
Creates a stored procedure to insert an order into `SalesOrderDetail`. It validates stock, assigns default values (if `UnitPrice` or `Discount` are not given), updates inventory, and prints appropriate status messages.

**sql2.sql** – *UpdateOrderDetails*  
Updates only the specified fields for a product in a given order. Retains original values for `NULL` parameters and adjusts stock based on quantity changes.

**sql3.sql** – *GetOrderDetails*  
Fetches all records for a given `OrderID`. If no matching records are found, prints:  
`"The OrderID XXXX does not exist"` and returns `1`.

**sql4.sql** – *DeleteOrderDetails*  
Deletes a product from an order only if both `OrderID` and `ProductID` exist in that combination. If invalid, prints a message and returns error code `-1`.

**sql5.sql** – *FormatDate_MMDDYYYY*  
Scalar function that takes a `DATETIME` input and returns the date in `MM/DD/YYYY` format.

**sql6.sql** – *FormatDate_YYYYMMDD*  
Scalar function that takes a `DATETIME` input and returns the date in `YYYYMMDD` format.

**sql7.sql** – *vwCustomerOrders View*  
Shows customer order information, including:  
`CompanyName`, `OrderID`, `OrderDate`, `ProductID`, `ProductName`, `Quantity`, `UnitPrice`, and `Total = Quantity * UnitPrice`.

**sql8.sql** – *vwCustomerOrders_Yesterday View*  
Same as `vwCustomerOrders`, but only includes orders placed **yesterday**.

**sql9.sql** – *MyProducts View*  
Displays active (non-discontinued) products along with their `ProductID`, `ProductName`, `QuantityPerUnit`, `UnitPrice`, supplier `CompanyName`, and `CategoryName`.

**sql10.sql** – *tr_DeleteOrderCascade Trigger*  
`INSTEAD OF DELETE` trigger on `Sales.SalesOrderHeader`. When an order is deleted, the trigger first deletes all corresponding records from `SalesOrderDetail` before deleting the order itself.

**sql11.sql** – *tr_CheckStockBeforeInsert Trigger*  
`INSTEAD OF INSERT` trigger on `SalesOrderDetail`. Before an insert, it checks for sufficient stock in `ProductInventory`. If insufficient, it aborts the insert and notifies the user.

---

## ✅ Requirements

- Microsoft SQL Server (2017 or later recommended)  
- AdventureWorks2019 Sample Database (restore `.bak` file)

---

## 📂 Usage

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Restore the **AdventureWorks2019** database if not already done.
4. Execute each `.sql` file in order or as needed.

---

## 📌 Notes

- All procedures are created under the default schema `dbo`.
- All scripts assume consistent naming conventions and no prior modification of the AdventureWorks schema.
