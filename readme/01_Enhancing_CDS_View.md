# Part 1: Enhancing the Data Model and UI

## 1. Correcting the Data Source
We start with a basic CDS view selecting from `zproduct`. For our full demo, we need to switch this to our demo table `zproduct_demo` which contains all the necessary fields.

**Action:** Change the selection source.
```abap
define root view entity ZIW_Products
  as select from zproduct_demo
```

## 2. Adding Fields
We need to expose more fields to build a complete application.
- `prd_name`: Product Name
- `prd_price`: Price
- `prd_currency`: Currency Code
- `last_changed_at`: For ETag (optimistic locking)

## 3. Adding Annotations
Annotations drive the UI and behavior of the application.

### UI Annotations
These control how fields appear in the Fiori Elements app.
- `@UI.lineItem`: Columns in the list report.
- `@UI.identification`: Fields in the object page header/body.
- `@UI.fieldGroup`: Grouping fields together.
- `@UI.headerInfo`: Title and description for the object page.

### Search Annotations
- `@Search.searchable: true`: Enables the search bar.
- `@Search.defaultSearchElement: true`: Specifies which field is searched (e.g., Product ID).

### Semantic Annotations
These tell the framework about the nature of the data.
- `@Semantics.amount.currencyCode`: Links a price field to its currency field.
- `@Semantics.systemDateTime.lastChangedAt`: Automatically handles the ETag for concurrency control.

**Final Result:**
The CDS view should now look like a rich data model ready for the UI.
