# Part 3: Service Definition and Value Help

## 1. Exposing the Service
The Service Definition exposes our CDS views as an OData service.
- `expose ZIW_Products;`

## 2. Adding Value Help
To provide a dropdown for the **Currency** field, we need a source of truth.
- We use the standard view `I_Currency`.
- **Crucial Step:** We must `expose I_Currency` in the Service Definition so the UI can access it.

## 3. Linking the Value Help
In the CDS view (`ZIW_Products`), we add the annotation:
```abap
@Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } }]
prd_currency
```
This tells the UI: "When the user edits `prd_currency`, show a list from `I_Currency`."
