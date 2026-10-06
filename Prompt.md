# MASTER PROMPT
## Professional Terminal-Based Frontend for Prolog AI Project

### Project Title

**Personalized Product Recommendation and Intelligent Store Placement System Using Prolog**

---

## ROLE

Act as an experienced **SWI-Prolog developer, Symbolic AI developer, and academic project mentor**.

I already have a Prolog-based recommendation system. Upgrade it into a **professional, interactive terminal application** that looks like a small real-world recommendation system while remaining **100% Prolog**.

The final application must run directly inside the **SWI-Prolog terminal**.

---

# 1. ABSOLUTE TECHNOLOGY REQUIREMENT

This project must use:

- SWI-Prolog
- Prolog predicates
- Prolog facts
- Prolog rules
- Prolog queries
- Dynamic predicates where necessary
- Prolog terminal input/output
- ANSI terminal formatting/colors if supported

### DO NOT USE

- Python
- Flask
- Java
- JavaScript
- HTML
- CSS
- React
- Node.js
- MongoDB
- MySQL
- SQL
- APIs
- Web servers
- Machine Learning
- Deep Learning
- Neural Networks
- External recommendation libraries

The project must remain **100% Prolog**.

---

# 2. MAIN GOAL

Create a professional-looking **terminal UI** for the recommendation system.

The terminal should behave like a small shopping/recommendation application.

The user should be able to:

1. View products
2. View product categories
3. Select a user
4. View purchase history
5. Search/view products
6. Purchase a product
7. Immediately receive recommendations
8. View related products
9. View frequently bought together products
10. View personalized recommendations
11. See recommendation explanations
12. View store-placement suggestions
13. Demonstrate Prolog backtracking
14. Exit the application

---

# 3. TERMINAL UI STYLE

Make the terminal interface look professional.

Use:

- Box borders
- Section headers
- Clear spacing
- Numbered menus
- Status messages
- Tables where useful
- Simple ANSI colors if supported
- Icons/symbols only when terminal compatibility is safe

Example:

```text
╔══════════════════════════════════════════════════════╗
║        PERSONALIZED PRODUCT RECOMMENDATION           ║
║              USING PROLOG — AI SYSTEM                ║
╚══════════════════════════════════════════════════════╝

                 MAIN MENU

  [1] View Products
  [2] View Categories
  [3] Select User
  [4] View Purchase History
  [5] Purchase Product
  [6] Get Recommendations
  [7] Related Products
  [8] Frequently Bought Together
  [9] Store Placement Intelligence
 [10] Explain Recommendation
 [11] Backtracking Demonstration
 [12] System Information
  [0] Exit

--------------------------------------------------------
Enter your choice:
```

If Unicode box characters are not supported, automatically provide an ASCII fallback.

---

# 4. HOME SCREEN

When the program starts:

```prolog
?- start.
```

Display:

```text
╔══════════════════════════════════════════════════════╗
║        PERSONALIZED PRODUCT RECOMMENDATION           ║
║       & INTELLIGENT STORE PLACEMENT SYSTEM           ║
║                     PROLOG                           ║
╚══════════════════════════════════════════════════════╝

AI LAB PROJECT
Symbolic AI | Rule-Based Recommendation

Features:
✓ Personalized Recommendations
✓ Related Product Recommendation
✓ Frequently Bought Together
✓ Explainable AI
✓ Store Placement Intelligence
✓ Prolog Backtracking

--------------------------------------------------------
Press Enter to continue...
```

Then open the main menu.

---

# 5. MAIN MENU

Implement:

```text
========================================================
                      MAIN MENU
========================================================

[1] View Products
[2] View Categories
[3] Select User
[4] View Purchase History
[5] Purchase Product
[6] Personalized Recommendations
[7] Related Product Recommendations
[8] Frequently Bought Together
[9] Store Placement Suggestions
[10] Explain Recommendation
[11] Backtracking Demonstration
[12] System Information
[0] Exit

--------------------------------------------------------
Current User: user2
--------------------------------------------------------

Enter choice:
```

Maintain the currently selected user using a dynamic predicate if necessary:

```prolog
:- dynamic current_user/1.
```

---

# 6. USER SELECTION

Provide:

```text
╔══════════════════════════════════════════════════════╗
║                    SELECT USER                       ║
╚══════════════════════════════════════════════════════╝

[1] user1
[2] user2
[3] user3

Enter user:
```

After selection:

```text
✓ User selected successfully.

Current User: user2
```

If the user does not exist:

```text
✗ Invalid user.

Please select:
user1
user2
user3
```

---

# 7. PRODUCT DISPLAY

Create a professional table.

Example:

```text
╔══════════════════════════════════════════════════════╗
║                   PRODUCT CATALOG                    ║
╚══════════════════════════════════════════════════════╝

ID   PRODUCT             CATEGORY
--------------------------------------------------------
1    Pizza               Fast Food
2    Burger              Fast Food
3    Sandwich            Fast Food
4    Fries               Fast Food
5    Soft Drink          Fast Food
6    Mobile              Electronics
7    Laptop              Electronics
8    Milk                Grocery
9    Bread               Grocery
10   Butter              Grocery
11   Eggs                Grocery
12   Mobile Case         Accessory
13   Tempered Glass      Accessory
14   Charger             Accessory
15   Laptop Bag          Accessory
16   Mouse               Accessory
--------------------------------------------------------
```

Use Prolog facts as the source.

Do not hardcode the display separately from the knowledge base.

---

# 8. CATEGORY VIEW

Show:

```text
╔══════════════════════════════════════════════════════╗
║                    CATEGORIES                        ║
╚══════════════════════════════════════════════════════╝

FAST FOOD
  • Pizza
  • Burger
  • Sandwich
  • Fries
  • Soft Drink

ELECTRONICS
  • Mobile
  • Laptop

GROCERY
  • Milk
  • Bread
  • Butter
  • Eggs

ACCESSORIES
  • Mobile Case
  • Tempered Glass
  • Charger
  • Laptop Bag
  • Mouse
```

Generate this from Prolog `category/2` facts.

---

# 9. PURCHASE FLOW

When the user chooses:

```text
[5] Purchase Product
```

Show:

```text
╔══════════════════════════════════════════════════════╗
║                  PURCHASE PRODUCT                    ║
╚══════════════════════════════════════════════════════╝

Current User: user2

Enter product:
```

Example:

```text
Enter product: mobile
```

Then:

```text
✓ Purchase successful.

User: user2
Product: mobile
```

Immediately run the recommendation engine.

---

# 10. REAL-TIME RECOMMENDATION

After purchase:

```text
╔══════════════════════════════════════════════════════╗
║              RECOMMENDATIONS GENERATED               ║
╚══════════════════════════════════════════════════════╝

You purchased:
→ Mobile

Recommended for you:

  1. Mobile Case
  2. Tempered Glass
  3. Charger

Why?

Mobile Case
→ Related to Mobile

Tempered Glass
→ Related to Mobile

Charger
→ Related to Mobile

✓ Recommendations generated using Prolog rules.
```

This must be generated dynamically from Prolog predicates.

Do NOT fake the output.

---

# 11. PERSONALIZED RECOMMENDATIONS

For user1:

```text
╔══════════════════════════════════════════════════════╗
║             PERSONALIZED RECOMMENDATIONS             ║
╚══════════════════════════════════════════════════════╝

Customer: user1

Purchase History:
• Pizza
• Burger
• Sandwich

Detected Preference:
→ FAST FOOD

Recommended Products:
--------------------------------------------------------
1. Fries
2. Soft Drink
--------------------------------------------------------

Reason:
The customer purchased multiple products from the
Fast Food category.

Inference:
purchased → category → preference → recommendation
```

The explanation must reflect the actual Prolog facts.

---

# 12. RELATED PRODUCT RECOMMENDATIONS

For a mobile purchase:

```text
╔══════════════════════════════════════════════════════╗
║              RELATED PRODUCT ENGINE                  ║
╚══════════════════════════════════════════════════════╝

Purchased Product:
→ Mobile

Related Products:
--------------------------------------------------------
1. Mobile Case
2. Tempered Glass
3. Charger
--------------------------------------------------------

Logic:
related(mobile, Product)

✓ Recommendation generated using Prolog inference.
```

---

# 13. FREQUENTLY BOUGHT TOGETHER

For milk:

```text
╔══════════════════════════════════════════════════════╗
║           FREQUENTLY BOUGHT TOGETHER                ║
╚══════════════════════════════════════════════════════╝

Product:
→ Milk

Frequently Bought Together:
--------------------------------------------------------
1. Bread
2. Butter
3. Eggs
--------------------------------------------------------

Reason:
These products have a predefined historical
co-purchase relationship.

✓ Association identified using Prolog facts.
```

---

# 14. STORE PLACEMENT INTELLIGENCE

Create a professional dashboard-like terminal screen:

```text
╔══════════════════════════════════════════════════════╗
║            STORE PLACEMENT INTELLIGENCE              ║
╚══════════════════════════════════════════════════════╝

PRODUCT ASSOCIATIONS

PRODUCT A       PRODUCT B       RELATION
--------------------------------------------------------
Milk            Bread           Frequently Bought
Milk            Butter          Frequently Bought
Milk            Eggs            Frequently Bought
Mobile          Mobile Case     Frequently Bought
Mobile          Tempered Glass  Frequently Bought
--------------------------------------------------------

PLACEMENT OPPORTUNITIES

→ Consider placing Bread near Milk.
→ Consider placing Butter near Milk.
→ Consider placing Eggs near Milk.

Note:
These are potential placement opportunities based on
historical co-purchase relationships. They do not
guarantee increased sales.
```

This wording is important for academic correctness.

---

# 15. EXPLAINABLE AI

Create:

```text
╔══════════════════════════════════════════════════════╗
║              WHY THIS RECOMMENDATION?                ║
╚══════════════════════════════════════════════════════╝

User:
user2

Recommendation:
Mobile Case

Reason:
You purchased Mobile.

Knowledge:
related(mobile, mobile_case).

Inference:
Purchased Mobile
       ↓
Related Product
       ↓
Mobile Case
       ↓
Recommendation

✓ Explanation generated from Prolog knowledge.
```

Do not use an external AI model for explanation.

The explanation must be generated from Prolog facts/rules.

---

# 16. BACKTRACKING DEMONSTRATION

Create a dedicated screen:

```text
╔══════════════════════════════════════════════════════╗
║                BACKTRACKING DEMO                    ║
╚══════════════════════════════════════════════════════╝

Query:

?- recommend_related(user2, Product).

Prolog searches the knowledge base...

Solution 1:
Product = mobile_case

Solution 2:
Product = tempered_glass

Solution 3:
Product = charger

No more solutions.

false.

--------------------------------------------------------
CONCEPT:
Prolog uses backtracking to search for alternative
valid solutions.
--------------------------------------------------------
```

Make this one of the strongest viva demonstrations.

---

# 17. SYSTEM INFORMATION

Create:

```text
╔══════════════════════════════════════════════════════╗
║                 SYSTEM INFORMATION                   ║
╚══════════════════════════════════════════════════════╝

Project:
Personalized Product Recommendation System

AI Approach:
Symbolic AI / Rule-Based AI

Language:
Prolog

Engine:
SWI-Prolog

Machine Learning:
Not Used

Database:
Not Used

Web Framework:
Not Used

Core Concepts:
• Knowledge Representation
• Facts
• Rules
• Queries
• Unification
• Logical Inference
• Backtracking
• Explainable Reasoning
```

---

# 18. ERROR HANDLING

Handle:

### Invalid menu

```text
✗ Invalid choice.

Please enter a number from 0 to 12.
```

### Invalid user

```text
✗ User not found.
```

### Invalid product

```text
✗ Product not found.
```

### No recommendation

```text
ℹ No recommendation is currently available.
```

### Duplicate purchase

```text
ℹ This product already exists in the user's purchase history.
```

Never crash the application because of invalid input.

---

# 19. PROLOG KNOWLEDGE BASE

Use simple facts.

Example:

```prolog
category(pizza, fast_food).
category(burger, fast_food).
category(sandwich, fast_food).
category(fries, fast_food).
category(soft_drink, fast_food).

category(mobile, electronics).
category(laptop, electronics).

category(milk, grocery).
category(bread, grocery).
category(butter, grocery).
category(eggs, grocery).

category(mobile_case, accessory).
category(tempered_glass, accessory).
category(charger, accessory).
category(laptop_bag, accessory).
category(mouse, accessory).
```

Users:

```prolog
user(user1).
user(user2).
user(user3).
```

Purchases:

```prolog
purchased(user1, pizza).
purchased(user1, burger).
purchased(user1, sandwich).

purchased(user2, mobile).

purchased(user3, milk).
```

Related products:

```prolog
related(mobile, mobile_case).
related(mobile, tempered_glass).
related(mobile, charger).

related(laptop, laptop_bag).
related(laptop, mouse).
```

Frequently bought:

```prolog
frequently_bought(milk, bread).
frequently_bought(milk, butter).
frequently_bought(milk, eggs).

frequently_bought(mobile, mobile_case).
frequently_bought(mobile, tempered_glass).
```

---

# 20. REQUIRED RECOMMENDATION RULES

Implement:

```prolog
likes_category(User, Category) :-
    purchased(User, Product),
    category(Product, Category).
```

```prolog
recommend_by_category(User, Product) :-
    likes_category(User, Category),
    category(Product, Category),
    \+ purchased(User, Product).
```

```prolog
recommend_related(User, Product) :-
    purchased(User, BoughtProduct),
    related(BoughtProduct, Product),
    \+ purchased(User, Product).
```

```prolog
recommend_frequently_bought(User, Product) :-
    purchased(User, BoughtProduct),
    frequently_bought(BoughtProduct, Product),
    \+ purchased(User, Product).
```

```prolog
placement_suggestion(Product1, Product2) :-
    frequently_bought(Product1, Product2).
```

Keep these rules understandable for a beginner-level AI Lab viva.

---

# 21. CURRENT USER

Use:

```prolog
:- dynamic current_user/1.
```

When selecting a user:

```prolog
retractall(current_user(_)),
assertz(current_user(User)).
```

The menu should display:

```text
Current User: user2
```

throughout the session.

---

# 22. REAL-TIME SESSION

The application should maintain the session while running.

Example:

```text
Start
 ↓
Select user2
 ↓
View products
 ↓
Purchase mobile
 ↓
Recommendation generated
 ↓
Purchase charger
 ↓
Recommendation updated
 ↓
View purchase history
 ↓
Explain recommendation
 ↓
Return to menu
```

Use dynamic predicates only where needed.

---

# 23. CODE QUALITY

The code must be:

- Clean
- Modular
- Beginner-friendly
- Properly commented
- Easy to explain
- Easy to modify
- Free from unnecessary complexity

Separate logical sections using comments:

```prolog
% USERS
% PRODUCTS
% PURCHASE HISTORY
% PRODUCT RELATIONSHIPS
% RECOMMENDATION RULES
% EXPLANATIONS
% TERMINAL UI
% MENU
```

---

# 24. FILE STRUCTURE

Prefer:

```text
Personalized-Product-Recommendation-Prolog/
│
├── recommendation.pl
├── README.md
├── sample_queries.txt
├── test_cases.txt
│
└── output/
    └── sample_output.txt
```

Prefer a single main `.pl` file because this is an AI Lab project.

Do not split into many files unless there is a clear reason.

---

# 25. EXECUTION

The final project must work like:

```bash
swipl
```

Then:

```prolog
?- [recommendation].
true.

?- start.
```

The application should then operate entirely through the terminal.

---

# 26. SAMPLE FINAL EXPERIENCE

The final terminal experience should approximately look like:

```text
╔══════════════════════════════════════════════════════╗
║        PERSONALIZED PRODUCT RECOMMENDATION           ║
║       & INTELLIGENT STORE PLACEMENT SYSTEM           ║
║                     PROLOG                           ║
╚══════════════════════════════════════════════════════╝

AI LAB PROJECT
Symbolic AI | Rule-Based Recommendation

Current User: user2

===================== MAIN MENU =======================

[1] View Products
[2] View Categories
[3] Select User
[4] View Purchase History
[5] Purchase Product
[6] Personalized Recommendations
[7] Related Product Recommendations
[8] Frequently Bought Together
[9] Store Placement Suggestions
[10] Explain Recommendation
[11] Backtracking Demonstration
[12] System Information
[0] Exit

Enter choice: 5

Enter product: mobile

✓ Purchase recorded.

╔══════════════════════════════════════════════════════╗
║              RECOMMENDATIONS GENERATED               ║
╚══════════════════════════════════════════════════════╝

You purchased:
→ Mobile

Recommended:

  1. Mobile Case
  2. Tempered Glass
  3. Charger

Reason:
These products are associated with Mobile.

✓ Powered by Prolog logical inference.
```

---

# 27. ACADEMIC REQUIREMENT

The UI must not hide the Prolog concepts.

The professor should be able to see:

```text
FACTS
 ↓
RULES
 ↓
QUERY
 ↓
UNIFICATION
 ↓
INFERENCE
 ↓
BACKTRACKING
 ↓
RECOMMENDATION
```

The project should therefore support both:

### User-friendly demonstration

```text
[6] Personalized Recommendations
```

and direct Prolog queries:

```prolog
?- recommend_related(user2, Product).
```

---

# 28. FINAL DELIVERABLES

Generate the complete final project containing:

### 1. `recommendation.pl`

Complete working Prolog application.

### 2. `README.md`

Include:

- Abstract
- Problem statement
- Objectives
- Existing system
- Proposed system
- Features
- Architecture
- Knowledge representation
- Facts
- Rules
- Recommendation logic
- Backtracking
- Store placement
- Explainability
- Installation
- Execution
- Sample output
- Test cases
- Limitations
- Future enhancements
- Viva questions

### 3. `sample_queries.txt`

Include all important Prolog queries.

### 4. `test_cases.txt`

Include functional test cases.

### 5. `output/sample_output.txt`

Include representative terminal output.

---

# 29. FINAL VIVA EXPLANATION

The final project must be explainable in this simple way:

> "Our project is a Personalized Product Recommendation and Intelligent Store Placement System using Prolog. We represent customer purchases, product categories, product relationships, and frequently purchased products as facts. We then define rules that allow Prolog to infer customer preferences and generate recommendations. For example, if a customer purchases a mobile, the system can recommend a mobile case, tempered glass, and charger. If milk and bread are frequently purchased together, the system can recommend bread and identify a potential placement opportunity. The system also demonstrates unification, logical inference, and backtracking. The entire application runs directly in SWI-Prolog through an interactive terminal interface, without Python, web technologies, databases, or Machine Learning."

---

# 30. MOST IMPORTANT RESTRICTION

DO NOT convert this into a web application.

DO NOT introduce Python.

DO NOT introduce Flask.

DO NOT introduce HTML/CSS/JavaScript.

DO NOT introduce Machine Learning.

DO NOT introduce a database.

The final output must be:

**SWI-Prolog + Prolog Knowledge Base + Prolog Rules + Prolog Terminal UI**

Start by inspecting the existing Prolog project if files are provided. Preserve the existing recommendation logic where correct, then upgrade the terminal interface and integrate all features into one polished, working application.

Finally, provide the complete runnable `recommendation.pl` and all supporting documentation.