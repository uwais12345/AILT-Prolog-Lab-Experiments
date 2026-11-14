# Complete Technical Explanation of `recommendation.pl`
**Project:** Personalized Product Recommendation & Intelligent Store Placement System  
**Implementation:** 100% Pure SWI-Prolog (No External Dependencies, No Python, No SQL, No Black-Box Models)  
**AI Paradigm:** Symbolic Artificial Intelligence / Knowledge Representation & First-Order Logical Inference  

---

## 1. Executive Summary & Paradigm

Modern commercial recommenders (e.g., Netflix, Amazon) predominantly use collaborative filtering, matrix factorization, or deep neural networks. While effective on massive datasets, these machine learning approaches:
1. Act as **black boxes** that cannot explain why a recommendation was made.
2. Require massive historical datasets for training.
3. Require separate infrastructure (databases, ML servers, model retraining pipelines).

This project demonstrates the **Symbolic AI approach**:
- Knowledge is represented explicitly using **declarative logic facts**.
- Reasoning is performed dynamically using **Horn clauses and logical inference rules**.
- Decisions are **100% deterministic, explainable, and verifiable** via logical proofs.
- Runtime state is managed natively in the Prolog knowledge base via **dynamic predicates**.

---

## 2. Architectural Structure of `recommendation.pl`

The file is organized into 10 structured sections:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        recommendation.pl                               │
├────────────────────────────────────────────────────────────────────────┤
│  1. USERS & DYNAMIC DECLARATIONS                                      │
│     - Declares predicates modifiable at runtime (user/1, purchased/2)  │
│     - Seed facts for users (user1..user4, ram) and active user state  │
├────────────────────────────────────────────────────────────────────────┤
│  2. PRODUCT CATALOG & CATEGORIES                                       │
│     - 16 core items, category mappings, and display label dictionaries │
├────────────────────────────────────────────────────────────────────────┤
│  3. PRODUCT RELATIONSHIPS & ASSOCIATIONS                               │
│     - Complementary items (related/2) & co-purchases (freq_bought/2)   │
├────────────────────────────────────────────────────────────────────────┤
│  4. CUSTOMER BEHAVIOR & PURCHASE HISTORY                               │
│     - Historical transactions, search logs, and view logs              │
├────────────────────────────────────────────────────────────────────────┤
│  5. RECOMMENDATION RULES & INFERENCE ENGINE                            │
│     - likes_category/2, recommend_by_category/2, recommend_related/2   │
│     - recommend_frequently_bought/2, placement_suggestion/2            │
├────────────────────────────────────────────────────────────────────────┤
│  6. TERMINAL FORMATTING & DISPLAY HELPERS                              │
│     - Unicode box drawing, safe I/O readers, flexible input resolvers  │
├────────────────────────────────────────────────────────────────────────┤
│  7. INTERACTIVE SCREENS & SUBMENUS                                     │
│     - Catalog views, Purchase screen, Dynamic Cart & Onboarding loop   │
│     - Personalized & related recommendation engines, Explainable AI    │
├────────────────────────────────────────────────────────────────────────┤
│  8. MAIN MENU & CONTROLLER LOOP                                        │
│     - 13-choice master loop, session state header, clean exit handler  │
├────────────────────────────────────────────────────────────────────────┤
│  9. ADMIN PANEL (SECURITY & CATALOG CRUD)                              │
│     - Password authentication ('admin123'), product add/edit/delete,   │
│     - user oversight, password modification                            │
├────────────────────────────────────────────────────────────────────────┤
│ 10. APPLICATION ENTRY POINT                                            │
│     - start/0 predicate and splash banner                              │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Detailed Walkthrough: Facts & Knowledge Representation

### 3.1 Dynamic Declarations (`:- dynamic ...`)
Prolog code is compiled as static by default. Static predicates cannot be altered during execution. To allow runtime modifications (e.g., adding a user, recording a purchase, adding an admin product), predicates are declared dynamic:

```prolog
:- dynamic user/1.
:- dynamic current_user/1.
:- dynamic purchased/2.
:- dynamic searched/2.
:- dynamic viewed/2.
:- dynamic product_id/2.
:- dynamic category/2.
:- dynamic display_name/2.
:- dynamic related/2.
:- dynamic frequently_bought/2.
:- dynamic admin_password/1.
```

### 3.2 User Knowledge Base
```prolog
user(user1).
user(user2).
user(user3).
user(user4).
user(ram).

current_user(user2).
```
- Defines valid user identities.
- `current_user/1` tracks session state. When a user switches identity, `retractall(current_user(_))` is called followed by `assertz(current_user(NewUser))`.

### 3.3 Product Catalog & Categories
The knowledge base assigns numeric IDs, categories, and human-readable names:
- **Fast Food:** `pizza`, `burger`, `sandwich`, `fries`, `soft_drink`
- **Electronics:** `mobile`, `laptop`
- **Grocery:** `milk`, `bread`, `butter`, `eggs`
- **Accessories:** `mobile_case`, `tempered_glass`, `charger`, `laptop_bag`, `mouse`

```prolog
product_id(1,  pizza).
category(pizza, fast_food).
display_name(pizza, 'Pizza').
category_name(fast_food, 'Fast Food').
```

### 3.4 Associations & Domain Relationships
Domain experts define how items correlate:
1. **Complementary Relationships (`related/2`):** Direct hardware or item accessories.
   ```prolog
   related(mobile, mobile_case).
   related(mobile, tempered_glass).
   related(mobile, charger).
   related(laptop, laptop_bag).
   related(laptop, mouse).
   ```
2. **Co-Purchase Affinity (`frequently_bought/2`):** Historical retail basket patterns.
   ```prolog
   frequently_bought(milk, bread).
   frequently_bought(milk, butter).
   frequently_bought(milk, eggs).
   ```

---

## 4. The Inference Engine & Recommendation Rules

The heart of `recommendation.pl` is Section 5, translating customer activity into personalized suggestions using first-order logical deduction.

### Rule 1: Preference Identification (`likes_category/2`)
```prolog
likes_category(User, Category) :-
    purchased(User, Product),
    category(Product, Category).
```
- **Semantics:** If `User` has purchased `Product`, and `Product` belongs to `Category`, then `User` is inferred to like `Category`.
- **Example:** `purchased(user1, pizza)` + `category(pizza, fast_food)` $\rightarrow$ `likes_category(user1, fast_food)`.

### Rule 2: Unpurchased Category Recommendations (`recommend_by_category/2`)
```prolog
recommend_by_category(User, Product) :-
    likes_category(User, Category),
    category(Product, Category),
    \+ purchased(User, Product).
```
- **Negation-as-Failure (`\+`):** The system checks that `purchased(User, Product)` **fails** (i.e., user has not already bought this specific item).
- **Behavior:** If `user1` bought `pizza`, `burger`, and `sandwich`, the query `recommend_by_category(user1, P)` deduces that `fries` and `soft_drink` should be recommended.

### Rule 3: Complementary / Related Products (`recommend_related/2`)
```prolog
recommend_related(User, Product) :-
    purchased(User, BoughtProduct),
    related(BoughtProduct, Product),
    \+ purchased(User, Product).
```
- **Cross-Selling:** Suggests accessories for purchased hardware that the user does not already own.

### Rule 4: Frequently Bought Together (`recommend_frequently_bought/2`)
```prolog
recommend_frequently_bought(User, Product) :-
    purchased(User, BoughtProduct),
    frequently_bought(BoughtProduct, Product),
    \+ purchased(User, Product).
```
- **Basket Bundling:** Emulates retail basket associations (e.g., milk $\rightarrow$ bread, butter, eggs).

### Rule 5: Store Placement Intelligence (`placement_suggestion/2`)
```prolog
placement_suggestion(Product1, Product2) :-
    frequently_bought(Product1, Product2).
```
- Recommends shelf/aisle placement for physical retail operations based on co-purchase facts.

---

## 5. Input Normalization & Resolution

In terminal applications, users may enter:
- Numeric product IDs (`1`, `6`)
- Plain lowercase atoms (`pizza`, `laptop`)
- Mixed case names (`Soft Drink`, `Mobile Case`)
- Numbers with trailing periods (`1.`)

`recommendation.pl` includes robust resolution predicates:

### `resolve_product/2`
```prolog
resolve_product(Input, Product) :-
    normalize_space(string(Trimmed), Input),
    Trimmed \== "",
    ( sub_string(Trimmed, _, 1, 0, ".") ->
        sub_string(Trimmed, 0, _, 1, Core)
    ;   Core = Trimmed
    ),
    ( number_string(N, Core), product_id(N, Product) -> true
    ; downcase_atom(Core, LowerAtom),
      ( category(LowerAtom, _) -> Product = LowerAtom
      ; atomic_list_concat(Parts, ' ', LowerAtom),
        atomic_list_concat(Parts, '_', UnderscoreAtom),
        category(UnderscoreAtom, _) -> Product = UnderscoreAtom
      ; display_name(Product, Core)
      )
    ).
```
1. Strips whitespace and optional trailing period.
2. Checks numeric ID lookup against `product_id/2`.
3. Falls back to lowercase atom check against `category/2`.
4. Replaces spaces with underscores (`mobile case` $\rightarrow$ `mobile_case`).
5. Checks against friendly `display_name/2`.

### `resolve_user_dynamic/3`
Supports choosing a user either by their list index number (`1`, `2`, `5`) or by typing their exact name (`ram`, `mydeen`, `user3`).

---

## 6. Onboarding & The Dynamic Shopping Cart

When a new user is added (via Option 11), the system launches a dedicated interactive cart workflow:

```
screen_add_new_user
       │
       ▼
Prompts for user name -> asserts user(Name) -> sets current_user(Name)
       │
       ▼
new_user_menu_loop(User)
 ├── [1] Add Product to Cart  ──> cart_add_loop(User)
 ├── [2] View Cart            ──> screen_new_user_view_cart(User)
 ├── [3] Personalized Recs   ──> screen_new_user_recommendations(User)
 └── [0] Return to Main Menu
```

### Key Cart Behaviors:
1. **Catalog Browsing:** Displays current products with their IDs and tags items already in the cart with `[in cart]`.
2. **Duplicate Prevention:** If the user enters an item already bought, it displays a gentle notification and continues.
3. **Out-of-Catalog Dynamic Addition:** If a user enters a product not present in the catalog (e.g., `biryani` or `smartwatch`):
   - Confirms it is not a valid ID number.
   - Prompts the user to assign a category (`[1] fast_food`, `[2] electronics`, `[3] grocery`, `[4] accessory`).
   - Automatically computes `NextId is MaxId + 1`.
   - Executes `assertz(product_id(...))`, `assertz(category(...))`, `assertz(display_name(...))`, and `assertz(purchased(...))`.
   - Immediately makes this new product eligible for logical inference across the entire system.
4. **Clean Exit:** Entering `0` or blank Enter terminates the addition loop cleanly.

---

## 7. Explainable AI (XAI) Architecture

Screen 9 (`screen_explain_recommendation`) exemplifies symbolic explainability:

```prolog
screen_explain_recommendation :-
    current_user(CurrentUser),
    ...
    % Traces related products
    ( (purchased(CurrentUser, Bought), related(Bought, Rec), \+ purchased(CurrentUser, Rec)) ->
        format('Recommendation: ~w~n', [RecName]),
        format('Reason: You purchased ~w.~n', [BoughtName]),
        format('Knowledge: related(~w, ~w).~n', [Bought, Rec]),
        writeln('Inference:'),
        format('Purchased ~w -> Related Product -> ~w -> Recommendation~n', [BoughtName, RecName])
    ...
```

Instead of displaying an uninterpretable probability score, the system renders the **exact logical proof**:
```
User: user2
Recommendation: Tempered Glass
Reason: You purchased Mobile.
Knowledge: related(mobile, tempered_glass).
Inference:
Purchased Mobile
       ↓
Related Product
       ↓
Tempered Glass
       ↓
Recommendation
```

---

## 8. Admin Panel: Security & Catalog CRUD

Section 9 provides full administration without restarting Prolog:

### Authentication
- Protected by `admin_password('admin123')`.
- Password check occurs before entering `admin_menu_loop`.

### Admin Capabilities:
| Option | Predicate | Logic & Behavior |
|--------|-----------|------------------|
| `[1]` View Products | `admin_view_products` | Tabular display of all IDs, products, and categories. |
| `[2]` Add Product | `admin_add_product` | Validates name uniqueness, gets category, computes next ID, asserts facts. |
| `[3]` Edit Category | `admin_edit_product` | Resolves item, retracts old `category(P, Old)`, asserts `category(P, New)`. |
| `[4]` Delete Product | `admin_delete_product` | Requires typing `YES` confirmation. Executes cascading retraction across `product_id`, `category`, `display_name`, `purchased`, `related`, and `frequently_bought`. |
| `[5]` View Users | `admin_view_users` | Lists all users with total transaction count using `findall/3` and `length/2`. |
| `[6]` View User History | `admin_view_user_history` | Inspects purchase logs for any specified user. |
| `[7]` Add User | `admin_add_user` | Creates user fact directly without cart loop. |
| `[8]` Change Password | `admin_change_password` | Verifies existing password, double-prompts for confirmation, updates `admin_password/1`. |

---

## 9. Controller Loop & Application Lifecycle

### Program Entry: `start/0`
```prolog
start :-
    screen_splash,
    main_menu_loop.
```
1. Displays the system splash screen.
2. Waits for user to press Enter.
3. Enters recursive `main_menu_loop/0`.

### Tail-Recursive Menu Loop
```prolog
main_menu_loop :-
    display_main_menu,
    write('Enter choice: '),
    flush_output,
    read_line_clean(Input),
    ...
    ( CleanInput == "0" ->
        writeln('Application terminated cleanly. Goodbye!')
    ; CleanInput == "1" ->
        screen_view_products, press_enter, main_menu_loop
    ...
```
- Uses **tail recursion**: After handling an option and waiting for Enter, it calls `main_menu_loop` again.
- SWI-Prolog applies **Tail-Call Optimization (TCO)**, preventing stack overflow even across hundreds of menu interactions.
- Input `0` terminates the loop, allowing clean exit.

---

## 10. How to Run & Verify

### Run the Interactive System
From the terminal:
```bash
cd ~/Desktop/Prolog_Project/Project
swipl -s recommendation.pl -g start -t halt
```

### Direct REPL Verification Queries
You can also launch `swipl -s recommendation.pl` directly and execute logical queries:

1. **Find what `user1` likes:**
   ```prolog
   ?- likes_category(user1, Cat).
   Cat = fast_food ;
   Cat = fast_food ;
   Cat = fast_food.
   ```
2. **Find category-based recommendations for `user1`:**
   ```prolog
   ?- recommend_by_category(user1, Product).
   Product = fries ;
   Product = soft_drink.
   ```
3. **Find related accessories for `user2`:**
   ```prolog
   ?- recommend_related(user2, Product).
   Product = mobile_case ;
   Product = tempered_glass ;
   Product = charger.
   ```
4. **Test store placement suggestions:**
   ```prolog
   ?- placement_suggestion(milk, Item).
   Item = bread ;
   Item = butter ;
   Item = eggs.
   ```

---

## 11. Viva Defense & Technical Cheat Sheet

| Question | Technical Answer |
|----------|------------------|
| **What AI paradigm is used?** | Symbolic AI / Rule-Based Expert System using Horn Clauses in First-Order Logic. |
| **Why not Machine Learning?** | Symbolic AI provides 100% deterministic transparency, zero dataset requirements, instant explainability, and mathematical auditability. |
| **How does Negation-as-Failure work?** | In Prolog, `\+ P` succeeds if and only if `P` cannot be proven true from known facts (Closed-World Assumption). We use it to ensure we don't recommend items the user already bought. |
| **How are state updates persisted?** | Through dynamic database manipulation: `assertz/1` appends new knowledge clauses, and `retractall/1` removes existing clauses at runtime. |
| **What search strategy does Prolog employ?** | Depth-First Search (DFS) with Chronological Backtracking and Robinson's Unification Algorithm. |
| **Why is Tail-Call Optimization important here?** | The interactive menu loops (`main_menu_loop`, `admin_menu_loop`, `cart_add_loop`) are recursive. TCO ensures constant stack space, preventing stack overflow. |

