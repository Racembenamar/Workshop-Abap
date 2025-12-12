# Workshop Teaching Guide: Building a Product Manager App (Interactive Flow)

**Role:** Teacher / Lead Developer
**Audience:** Students with no ABAP/Fiori background.
**Goal:** Build a fully functional Fiori app from scratch using RAP, seeing results at every step.

---

## Phase 1: The "Hello World" (Getting something on screen)

### Step 1: The Data Model (CDS)
**Context:** "We need to fetch data from the database."
**Action:** Create `ZIW_Products` selecting from `zproduct_demo`.
**State:** Just a data definition. No app yet.

### Step 2: The Pipeline (Service Definition & Binding)
**Context:** "We have data, but the web browser can't speak 'ABAP'. We need a translator."
**Action:**
1.  Create Service Definition `Zui_products`.
2.  Create Service Binding (OData V4) and **Publish**.
**Interpretation:** "Now our data is available as a web service (OData)."

### Step 3: The First Look (Preview)
**Context:** "Let's see what we built!"
**Action:** Double-click the entity in the Service Binding and click **Preview**.
**Observation:** "It works! But... it's just a raw list. No columns, no titles. It looks broken."
**Lesson:** "Fiori Elements needs instructions on *how* to display the data."

---

## Phase 2: Shaping the UI (Annotations)

### Step 4: Adding Columns & Form Fields
**Context:** "Let's tell the app to show the Product ID and Name."
**Action:**
1.  Add `@UI.lineItem` to `product_id` and `prd_name`.
2.  **Refresh the Preview.**
**Observation:** "Boom! We have a table."
3.  Click on a row. "It's empty or blank! Why?"
**Lesson:** "We told the app *which* fields to show, but not *where* to put them on the detail page."

### Step 4.5: Structuring the Page (Facets)
**Context:** "We need to define the layout of the detail page."
**Action:**
1.  Add the `@UI.facet` annotation to the top of the view.
    ```abap
    @UI.facet: [ { id: 'Detail', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Product Detail', position: 10 } ]
    ```
2.  Add `@UI.identification` to the fields you want in this section.
3.  **Refresh.**
**Observation:** "Now the detail page works! The 'Product Detail' section appears with our fields."

---

## Phase 3: Making it Functional (Behavior)

### Step 5: Enabling Full Editing (CRUD + Drafts)
**Context:** "We want to create and edit data. But modern apps need two things: Safety (Locking) and Convenience (Drafts)."
**The Problem:** "If we just enable `create/update`, the system might block us or behave strictly. We want the full 'Fiori Experience' with auto-save."
**Action:**
1.  **Update CDS View:** Add the ETag field.
    ```abap
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at
    ```
2.  **Create BDEF with Drafts:**
    ```abap
    managed;
    strict ( 2 );
    with draft; // <--- Enable Drafts
    define behavior for ZIW_Products
    persistent table zproduct_demo
    draft table zproducts_draft // <--- Define Draft Table
    lock master
    total etag last_changed_at // <--- Required for Drafts
    {
      create;
      update;
      delete;
      
      field ( readonly ) product_id;
      field ( readonly ) last_changed_at;

      draft action Edit;
      draft action Resume;
      draft action Activate;
      draft action Discard;
      
      draft determine action Prepare {}
    }
    ```
3.  **Generate Draft Table:** Use the Quick Fix (Ctrl+1) to create `zproducts_draft`.
4.  **Refresh.**
**Observation:** "Now we have everything: Create, Edit, Delete, and the 'Draft' badge!"
**Lesson:** "Drafts and ETags work together to provide a robust editing environment."

---

## Phase 4: Intelligence (Business Logic)

### Step 7: Automation (Early Numbering)
**Context:** "Typing 'PROD-001' manually is annoying. Let the system do it."
**Action:**
1.  Add `early numbering` to BDEF.
2.  Implement the `early_numbering_create` method in the Class.
3.  **Test:** Click Create. The ID is generated instantly.

### Step 8: Rules (Validations & Determinations)
**Context:** "I can enter a price of -100. That's bad."
**Action:**
1.  Add `validation validatePrice` to BDEF.
2.  Implement logic in Class.
3.  **Test:** Try to save a negative price. See the error message.

### Step 9: Custom Actions (The Discount Button)
**Context:** "CRUD is boring. Let's add a magic button to do something specific, like applying a discount."
**Action:**
1.  **Update BDEF:** Add `action applyDiscount result [1] $self;`.
2.  **Update CDS:** Add the button to the UI.
    ```abap
    @UI.lineItem: [ ..., { type: #FOR_ACTION, dataAction: 'applyDiscount', label: '10% Discount' } ]
    ```
3.  **Implement Logic:** Write the `applyDiscount` method in the Class.
4.  **Test:** Select a product, click the button, and watch the price drop.

---

## Phase 5: User Experience (UX)

### Step 9: Value Help
**Context:** "I don't know the currency codes. Help me."
**Action:**
1.  Add `@Consumption.valueHelpDefinition` to `prd_currency`.
2.  Expose `I_Currency` in Service Definition.
3.  **Refresh.**
**Observation:** "Now we have a dropdown list."

---

## Summary for Students
We followed a **"Build -> Run -> Improve"** cycle:
1.  **Build:** Create the basic data service.
2.  **Run:** See the empty/raw app.
3.  **Improve:** Add features (UI, CRUD, Logic) one by one and see the impact immediately.
