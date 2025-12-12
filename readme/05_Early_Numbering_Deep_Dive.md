# Part 5: Early Numbering Deep Dive

## The Concept
**Early Numbering** means the primary key (ID) is generated **before** the final save, typically at the moment the user initializes the creation.

## Why use it?
In a **Draft** scenario, the system needs a key to store the draft version in the draft table. If we relied on the database to generate the ID (Late Numbering), we wouldn't have an ID for the draft.

## Implementation
1. **BDEF:** Add `early numbering` and make the key field `readonly`.
2. **Class Method:** `early_numbering_create`.
    - **Logic:** Find the max existing ID and increment it.
    - **Mapping:** We must map the temporary ID (`%cid`) to the new permanent ID (`product_id`).

## The Critical Fix
When mapping the result, we **MUST** include `%is_draft`.
```abap
APPEND VALUE #( %cid      = <entity>-%cid
                %is_draft = <entity>-%is_draft  <-- CRITICAL
                product_id = max_id ) TO mapped-ziw_products.
```
Without this, the framework doesn't know if the new ID belongs to the draft or the active entity, leading to a dump.
