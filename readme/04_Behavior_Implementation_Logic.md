# Part 4: Behavior Implementation (Logic)

We implement the logic in a local handler class `lhc_ZIW_Products`.

## 1. Determinations
**What:** Automatically calculate or set data.
**Example:** `setCurrency`
- **Trigger:** `on modify` (when data changes).
- **Logic:** If `prd_currency` is empty, set it to 'EUR'.
- **EML:** Uses `MODIFY ENTITIES` to update the field.

## 2. Validations
**What:** Check data consistency before saving.
**Example:** `validatePrice`
- **Trigger:** `on save`.
- **Logic:** Check if `prd_price` <= 0.
- **Reporting:** If invalid, add to `failed` (stops save) and `reported` (shows message).

## 3. Actions
**What:** Custom business logic triggered by a button.
**Example:** `applyDiscount`
- **Logic:** Reduce price by 10%.
- **EML:**
    1. `READ ENTITIES`: Get current price.
    2. Calculate new price.
    3. `MODIFY ENTITIES`: Update the price.
    4. Return result for UI update.

## 4. Entity Manipulation Language (EML)
EML is the ABAP syntax for interacting with RAP business objects.
- `READ ENTITIES`: Read data from the buffer or DB.
- `MODIFY ENTITIES`: Change data in the buffer.
- `%tky`: Transaction Key (handles draft/active distinction automatically).
