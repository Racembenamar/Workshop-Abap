@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZIW_Products'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true   
@UI.headerInfo: { typeName: 'Product', title: { value: 'product_id' } }

define root view entity ZIW_Products
  as select from zproduct_demo
{
      @UI.lineItem: [{ label: 'Product ID',position: 10 }]
      @UI.identification: [{ label: 'Product ID',position: 10 }]
      @UI.facet: [ 
                { 
                    id:              'Detail',
                    purpose:         #STANDARD,
                    type:            #IDENTIFICATION_REFERENCE,
                    label:           'Product Detail',
                    position:        10 
                 } 
              ] 
              
                            
      @Search.defaultSearchElement: true
      key product_id,

      @Semantics.text: true
      @UI.lineItem: [{ label: 'Product Name',position: 20 }]
      @UI.identification: [{ label: 'Product Name',position: 20 }]
      prd_name,
      
      
      @Semantics.amount.currencyCode: 'prd_currency'
      @UI.lineItem: [
          { label: 'Product Price', position: 30 },
          { type: #FOR_ACTION, dataAction: 'applyDiscount', label: '10% Discount', position: 10 }
      ]
      @UI.identification: [
          { label: 'Product Price', position: 30 },
          { type: #FOR_ACTION, dataAction: 'applyDiscount', label: '10% Discount', position: 10 }
      ]
      prd_price,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } }]
      prd_currency,
      
      
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
}
