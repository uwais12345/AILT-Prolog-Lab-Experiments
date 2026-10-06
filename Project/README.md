# Personalized Product Recommendation and Intelligent Store Placement System Using Prolog

[![SWI-Prolog](https://img.shields.io/badge/Prolog-SWI--Prolog%209.2%2B-blue.svg)](https://www.swi-prolog.org/)
[![Paradigm](https://img.shields.io/badge/AI%20Paradigm-Symbolic%20AI-success.svg)]()
[![Pure Logic](https://img.shields.io/badge/Pure%20Prolog-100%25-brightgreen.svg)]()
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)]()

> **Academic AI Lab Project**  
> **Domain:** Knowledge Representation & Reasoning | Expert Systems | Rule-Based Symbolic AI  
> **Technology:** 100% Pure SWI-Prolog (No Python, No ML, No Web Frameworks, No Databases)

---

## Table of Contents
1. [Abstract](#abstract)
2. [Problem Statement](#problem-statement)
3. [Objectives](#objectives)
4. [Existing System vs. Proposed System](#existing-system-vs-proposed-system)
5. [Key Features](#key-features)
6. [System Architecture](#system-architecture)
7. [Knowledge Representation](#knowledge-representation)
   - [Declarative Facts](#declarative-facts)
   - [Inference Rules](#inference-rules)
   - [Dynamic Predicates & Session State](#dynamic-predicates--session-state)
8. [Recommendation Logic](#recommendation-logic)
   - [Category-Based Preference Recommendation](#1-category-based-preference-recommendation)
   - [Complementary & Related Products](#2-complementary--related-products)
   - [Frequently Bought Together (Co-Purchase)](#3-frequently-bought-together-co-purchase)
9. [Store Placement Intelligence](#store-placement-intelligence)
10. [Explainable AI (XAI) Facility](#explainable-ai-xai-facility)
11. [Prolog Unification & Backtracking Demonstration](#prolog-unification--backtracking-demonstration)
12. [Installation & Execution Guide](#installation--execution-guide)
13. [Interactive Terminal Walkthrough](#interactive-terminal-walkthrough)
14. [Direct Prolog Queries Reference](#direct-prolog-queries-reference)
15. [Functional Test Cases Summary](#functional-test-cases-summary)
16. [Limitations & Future Enhancements](#limitations--future-enhancements)
17. [Comprehensive Viva Questions & Answers](#comprehensive-viva-questions--answers)
18. [Project File Structure](#project-file-structure)

---

## Abstract

Commercial recommendation engines overwhelmingly depend on deep neural networks and statistical collaborative filtering. While functional in massive cloud environments, these models suffer from the "black-box problem," extreme computational resource requirements, cold-start latency, and a complete inability to mathematically justify their suggestions to end users or auditors.

This project implements an **expert recommendation and retail store placement system built entirely in SWI-Prolog**. The system models customer transaction histories, multi-level product taxonomies, cross-product affinities, and market basket relationships as first-order declarative facts. Using Horn clauses and SLD resolution, the Prolog engine performs deterministic logical inference, Robinson unification, and chronological backtracking to deduce user preferences, recommend related and co-purchased items, optimize physical supermarket shelf arrangements, and provide step-by-step reasoning chains for Explainable AI (XAI).

The application features an interactive terminal user interface directly inside the SWI-Prolog environment, proving that classical logic programming provides an efficient, lightweight, and auditable solution to retail intelligence.

---

## Problem Statement

Modern e-commerce and brick-and-mortar retail platforms face two interconnected challenges:
1. **Opaque Recommendations:** Machine learning recommendation models cannot explain *why* an item was recommended. When customers or regulators demand accountability, statistical models provide weights instead of logic.
2. **Disconnected Online & Physical Merchandising:** Recommendation algorithms often operate separately from physical store inventory layouts, ignoring cross-selling affinities when designing retail shelf placements.
3. **Over-Engineering in Academic Settings:** Many projects rely on massive Python stacks, external APIs, and cloud services when the underlying problem is fundamentally a formal knowledge representation challenge solvable through declarative logic.

---

## Objectives

- **Develop a 100% Pure Prolog Application:** Eliminate all external dependencies, Python scripts, JavaScript, SQL databases, and web servers.
- **Implement Rule-Based Recommendation Mechanisms:**
  - Implicit category preference learning via historical purchases.
  - Complementary accessory recommendations via relational graphs.
  - Market basket co-purchase bundle detection.
- **Provide Intelligent Retail Shelf Placement:** Generate actionable store layout suggestions based on customer co-purchase patterns with realistic academic disclaimers.
- **Expose Explainable AI (XAI):** Present transparent, human-readable logical deduction chains illustrating: `Purchased Product -> Known Fact -> Logical Rule -> Recommendation`.
- **Demonstrate Prolog Core Strengths:** Visually demonstrate unification, depth-first search, choice points, and backtracking both within an interactive terminal UI and through direct Prolog top-level queries.

---

## Existing System vs. Proposed System

| Dimension | Existing System (Machine Learning / Python) | Proposed System (Symbolic AI / Prolog) |
|---|---|---|
| **Paradigm** | Sub-symbolic, statistical matrix factorization | Declarative, first-order symbolic logic |
| **Explainability** | Opaque black-box (feature weights, embeddings) | Fully explainable formal deduction chains |
| **Dependencies** | Python, NumPy, Pandas, PyTorch/TensorFlow, Flask | 100% Pure SWI-Prolog standard distribution |
| **Data Requirements** | Thousands of historical records to avoid cold start | Instantaneous reasoning from initial facts |
| **Hardware Footprint** | Gigabytes of RAM, GPU acceleration preferred | Sub-20 MB RAM footprint, runs on any CPU |
| **Verification** | Empirical approximations with error margins | Mathematically verifiable and deterministic |
| **User Interface** | Web browser with bloated Node/React stacks | Clean, lightweight ANSI terminal interface |

---

## Key Features

1. **Interactive Terminal Frontend:** Complete with Unicode box borders, centered headers, clean numbered menus, and error-tolerant input readers.
2. **Session State Management:** Dynamically tracks active users (`user1`, `user2`, `user3`) and allows instant switching without restarting the process.
3. **Dynamic Catalog & Category Browser:** Displays 16 products across 4 categories (Fast Food, Electronics, Grocery, Accessory) rendered from knowledge base facts.
4. **Interactive Purchase Flow:** Allows purchasing items using numeric IDs or names, automatically checks for duplicates, and updates session facts in memory.
5. **Real-Time Recommendation Generation:** Instantly triggers cross-category and complementary recommendations upon completing a purchase.
6. **Store Placement Intelligence:** Translates co-purchase frequencies into physical shelf-space optimization rules.
7. **Interactive Backtracking Inspector:** Demonstrates step-by-step how Prolog traverses choice points, finds solutions, backtracks, and returns `false.`.
8. **Dual-Mode Operation:** Functions both as an interactive menu-driven terminal app (`?- start.`) and as a queryable logic engine (`?- recommend_related(user2, P).`).

---

## System Architecture

```text
+-----------------------------------------------------------------------------------+
|                            INTERACTIVE TERMINAL UI                                |
|          (Menu Loop, Screen Formatters, Unicode Borders, Input Parser)            |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
|                        PROLOG LOGICAL INFERENCE ENGINE                            |
|             (SLD Resolution, Robinson Unification, Chronological Backtracking)   |
+-----------------------------------------+-----------------------------------------+
                                          |
             +----------------------------+----------------------------+
             |                                                         |
             v                                                         v
+-----------------------------+                           +-----------------------------+
|    DECLARATIVE RULES        |                           |       KNOWLEDGE BASE        |
|  - likes_category/2         |                           |  - user/1                   |
|  - recommend_by_category/2  |                           |  - category/2               |
|  - recommend_related/2      |                           |  - related/2                |
|  - recommend_frequently/2   |                           |  - frequently_bought/2      |
|  - placement_suggestion/2   |                           |  - product_id/2             |
|  - explain_recommendation/3 |                           |  - display_name/2           |
+-----------------------------+                           +-----------------------------+
                                                                       ^
                                                                       | (Dynamic Updates)
                                                          +------------+----------------+
                                                          |  DYNAMIC RUNTIME MEMORY     |
                                                          |  - current_user/1           |
                                                          |  - purchased/2 (assertz)    |
                                                          +-----------------------------+
```

---

## Knowledge Representation

### Declarative Facts

```prolog
% Registered Users
user(user1).
user(user2).
user(user3).

% Product Catalog & Taxonomies
category(pizza,      fast_food).
category(burger,     fast_food).
category(sandwich,   fast_food).
category(fries,      fast_food).
category(soft_drink, fast_food).

category(mobile,     electronics).
category(laptop,     electronics).

category(milk,       grocery).
category(bread,      grocery).
category(butter,     grocery).
category(eggs,       grocery).

category(mobile_case,    accessory).
category(tempered_glass, accessory).
category(charger,        accessory).
category(laptop_bag,     accessory).
category(mouse,          accessory).

% Complementary Product Relationships
related(mobile, mobile_case).
related(mobile, tempered_glass).
related(mobile, charger).
related(laptop, laptop_bag).
related(laptop, mouse).

% Historical Co-Purchase Patterns (Frequently Bought Together)
frequently_bought(milk, bread).
frequently_bought(milk, butter).
frequently_bought(milk, eggs).
frequently_bought(mobile, mobile_case).
frequently_bought(mobile, tempered_glass).
```

### Inference Rules

```prolog
% 1. Infer category preference based on customer purchases
likes_category(User, Category) :-
    purchased(User, Product),
    category(Product, Category).

% 2. Recommend unpurchased items from preferred category
recommend_by_category(User, Product) :-
    likes_category(User, Category),
    category(Product, Category),
    \+ purchased(User, Product).

% 3. Recommend complementary accessories
recommend_related(User, Product) :-
    purchased(User, BoughtProduct),
    related(BoughtProduct, Product),
    \+ purchased(User, Product).

% 4. Recommend bundle co-purchases
recommend_frequently_bought(User, Product) :-
    purchased(User, BoughtProduct),
    frequently_bought(BoughtProduct, Product),
    \+ purchased(User, Product).

% 5. Store placement affinity rule
placement_suggestion(Product1, Product2) :-
    frequently_bought(Product1, Product2).
```

### Dynamic Predicates & Session State

To maintain session state during runtime without relying on a SQL database, the following dynamic predicates are registered:

```prolog
:- dynamic current_user/1.
:- dynamic purchased/2.
:- dynamic searched/2.
:- dynamic viewed/2.
```

- **User Switch:** `retractall(current_user(_)), assertz(current_user(NewUser)).`
- **Product Purchase:** `assertz(purchased(User, Product)).`

---

## Recommendation Logic

### 1. Category-Based Preference Recommendation
- **Premise:** Customers who purchase multiple items within a category have an established affinity for that category.
- **Logic:** Identifies all categories where the customer has transactions. Identifies all products mapped to those categories. Employs Prolog's negation-as-failure (`\+ purchased(User, Product)`) to filter out items the customer already owns.
- **Example:** `user1` bought `pizza`, `burger`, `sandwich` (Fast Food). System recommends `fries` and `soft_drink`.

### 2. Complementary & Related Products
- **Premise:** Certain hardware purchases require or benefit from direct accessories.
- **Logic:** Traverses `related/2` relations linked to products in the user's purchase history.
- **Example:** `user2` bought `mobile`. System recommends `mobile_case`, `tempered_glass`, and `charger`.

### 3. Frequently Bought Together (Co-Purchase)
- **Premise:** Items frequently bought concurrently in market baskets suggest strong natural affinity.
- **Logic:** Evaluates `frequently_bought/2` co-occurrence facts.
- **Example:** `user3` bought `milk`. System recommends `bread`, `butter`, and `eggs`.

---

## Store Placement Intelligence

Retail merchandising relies on cross-category visual association to drive incremental basket size. The system maps customer co-purchase facts directly to store physical shelf arrangements:

```text
╔══════════════════════════════════════════════════════╗
║             STORE PLACEMENT INTELLIGENCE             ║
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
→ Consider placing Mobile Case near Mobile.
→ Consider placing Tempered Glass near Mobile.

Note:
These are potential placement opportunities based on
historical co-purchase relationships. They do not
guarantee increased sales.
```

---

## Explainable AI (XAI) Facility

Unlike statistical neural networks, every suggestion generated by Prolog can be formally justified through its derivation tree:

```text
╔══════════════════════════════════════════════════════╗
║               WHY THIS RECOMMENDATION?               ║
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

---

## Prolog Unification & Backtracking Demonstration

When querying `?- recommend_related(user2, Product).`, Prolog executes depth-first search with choice points:

```text
╔══════════════════════════════════════════════════════╗
║                  BACKTRACKING DEMO                   ║
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
valid solutions across clauses in the knowledge base.
--------------------------------------------------------
```

1. **Step 1:** Prolog evaluates `purchased(user2, BoughtProduct)` -> unifies `BoughtProduct = mobile`.
2. **Step 2:** Prolog searches for `related(mobile, Product)` -> matches first fact `related(mobile, mobile_case)`.
3. **Step 3:** Checks `\+ purchased(user2, mobile_case)` -> succeeds. Outputs **Solution 1**.
4. **Step 4:** Upon requesting alternative solutions, Prolog backtracks to the choice point in `related/2` and unifies with `tempered_glass`. Outputs **Solution 2**.
5. **Step 5:** Backtracks again, matches `charger`. Outputs **Solution 3**.
6. **Step 6:** No further clauses exist. Goal fails and outputs `false.`.

---

## Installation & Execution Guide

### Prerequisites
- Install **SWI-Prolog** (v8.x or v9.x):
  ```bash
  # Ubuntu / Debian
  sudo apt-get update
  sudo apt-get install swi-prolog

  # macOS (Homebrew)
  brew install swi-prolog

  # Windows
  # Download installer from https://www.swi-prolog.org/
  ```

### Launching the Application
1. Navigate to the project root directory:
   ```bash
   cd /path/to/Prolog_Project
   ```
2. Start SWI-Prolog:
   ```bash
   swipl
   ```
3. Consult the program and run `start.`:
   ```prolog
   ?- [recommendation].
   true.

   ?- start.
   ```

Alternatively, launch directly in one command from your bash terminal:
```bash
swipl -s recommendation.pl -g "start."
```

---

## Interactive Terminal Walkthrough

Upon entering `start.`, the system presents the following main menu:

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

### Complete User Session Flow:
1. **Choose [1]:** View complete product catalog with product IDs (1 to 16).
2. **Choose [3]:** Switch to `user1`.
3. **Choose [4]:** Review `user1`'s purchase history (Pizza, Burger, Sandwich).
4. **Choose [6]:** View personalized recommendations for `user1` (Fries, Soft Drink).
5. **Choose [3]:** Switch back to `user2`.
6. **Choose [5]:** Purchase a product. Enter `laptop` (or ID `7`).
7. **Immediate Trigger:** Receive real-time recommendations: Laptop Bag & Mouse with reasoning!
8. **Choose [10]:** Inspect explainable AI deduction tree.
9. **Choose [11]:** Run backtracking demonstration.
10. **Choose [0]:** Cleanly terminate the application.

---

## Direct Prolog Queries Reference

For academic evaluation or direct inspection, evaluators can query the knowledge base directly from the Prolog interpreter prompt:

```prolog
% Find category preference of user1:
?- likes_category(user1, Cat).

% Find category recommendations for user1:
?- recommend_by_category(user1, Prod).

% Find related accessories for user2 (press ';' to backtrack):
?- recommend_related(user2, Prod).

% Find frequently bought products for user3:
?- recommend_frequently_bought(user3, Prod).

% Find all store placement pairs:
?- placement_suggestion(A, B).

% Test dynamic transaction:
?- assertz(purchased(user2, laptop)).
?- recommend_related(user2, P).
```

---

## Functional Test Cases Summary

All 15 formal test cases executed and passed with 100% compliance:

| Test ID | Module | Scenario | Expected Result | Status |
|---|---|---|---|---|
| **TC-01** | Splash Screen | Launch via `start/0` | Unicode header & feature list | **PASS** |
| **TC-02** | Catalog | View 16 products | Formatted ID/Product/Category table | **PASS** |
| **TC-03** | Taxonomy | Category grouping | 4 category blocks with sub-items | **PASS** |
| **TC-04** | Session | Switch user to `user1` | Session updated in `current_user/1` | **PASS** |
| **TC-05** | Error Handling | Invalid user `user99` | Graceful error prompt, no crash | **PASS** |
| **TC-06** | History | View `user1` history | Lists Pizza, Burger, Sandwich | **PASS** |
| **TC-07** | Preference | Recommendations for `user1` | Recommends Fries and Soft Drink | **PASS** |
| **TC-08** | Related | Related items for `user2` | Recommends Case, Glass, Charger | **PASS** |
| **TC-09** | Co-Purchase | Frequently bought for `user3` | Recommends Bread, Butter, Eggs | **PASS** |
| **TC-10** | Placement | Store placement intelligence | 5 association pairs & disclaimer | **PASS** |
| **TC-11** | XAI | Why recommendation for `user2` | Complete formal deduction chain | **PASS** |
| **TC-12** | Backtracking | Demo `recommend_related/2` | 3 sequential solutions and `false.` | **PASS** |
| **TC-13** | Purchase Flow | User purchases `laptop` | Asserted & instant recommendations | **PASS** |
| **TC-14** | Duplicate Guard | Re-purchase `mobile` | Warning displayed, duplicate blocked | **PASS** |
| **TC-15** | System & Exit | View info & Option 0 | Clean metadata & graceful exit | **PASS** |

*(For the complete functional test document, see [test_cases.txt](file:///home/mohamed-uwais-mn/Desktop/Prolog_Project/test_cases.txt)).*

---

## Limitations & Future Enhancements

### Limitations
1. **In-Memory Session Storage:** Dynamic facts asserted during a session (`purchased/2`) reside in volatile RAM and reset when SWI-Prolog halts.
2. **Deterministic Rules:** Recommendations are exact logical inferences without probabilistic confidence scores or fuzzy weighting.
3. **Manual Taxonomy Maintenance:** New categories and relationships must be declared as Prolog clauses rather than auto-extracted from text streams.

### Future Enhancements
1. **Persistent Fact Serialization:** Add Prolog predicates (`tell/1`, `listing/1`) to save runtime assertions to a `.pl` persistence ledger on exit.
2. **Probabilistic Reasoning:** Integrate ProbLog or certainty factor models to assign percentage confidence ratings to co-purchase affinities.
3. **Multi-Constraint Optimization:** Expand store placement rules with aisle distance metrics and shelf capacity constraints.

---

## Comprehensive Viva Questions & Answers

### 1. Fundamentals of Prolog & Symbolic AI
**Q1: What is Prolog and what programming paradigm does it represent?**  
*A:* Prolog (Programming in Logic) is a declarative, rule-based logic programming language founded on first-order predicate calculus. In contrast to imperative languages (C, Python) where programmers prescribe *how* to compute, Prolog programs specify *what* relationships exist through facts and rules, allowing the built-in inference engine to deduce answers.

**Q2: What is the difference between a Fact, a Rule, and a Query in Prolog?**  
*A:* 
- **Fact:** An unconditional assertion assumed to be true in the domain (e.g., `category(pizza, fast_food).`).
- **Rule:** A conditional assertion consisting of a Head and a Body linked by `:-` (if), stating that the Head is true if the Body goals succeed (e.g., `likes_category(U, C) :- purchased(U, P), category(P, C).`).
- **Query:** A goal submitted to the Prolog engine to test truth value or find variable bindings (e.g., `?- purchased(user1, pizza).`).

**Q3: What is a Horn clause?**  
*A:* A Horn clause is a disjunction of literals with at most one positive (unnegated) literal. Definite clauses (Prolog rules and facts) have exactly one positive literal. Prolog's computation is based on SLD resolution over Horn clauses.

---

### 2. Search & Inference Mechanism
**Q4: How does Prolog search for answers to a query?**  
*A:* Prolog utilizes **Depth-First Search (DFS)** with **Chronological Backtracking**. It evaluates goals from left to right, searching the knowledge base from top to bottom.

**Q5: What is Unification in Prolog?**  
*A:* Unification is the algorithmic process of making two first-order terms identical by finding a Most General Unifier (MGU) for their variables. If term $T_1$ is `category(pizza, C)` and $T_2$ is `category(pizza, fast_food)`, unification binds variable `C = fast_food`.

**Q6: What is Backtracking and how is it demonstrated in this project?**  
*A:* When a sub-goal fails or when alternative solutions are requested via semicolon `;`, Prolog retreats to the most recent **choice point**, unwinds variable bindings, and attempts the next alternative clause. In Option 11, querying `recommend_related(user2, Product)` finds `mobile_case`, backtracks to find `tempered_glass`, backtracks to find `charger`, and finally returns `false.` when choices are exhausted.

**Q7: What is the Closed-World Assumption (CWA) and Negation-as-Failure (NAF)?**  
*A:* Under the Closed-World Assumption, anything that cannot be proven true from the knowledge base is presumed false. Prolog implements this via **Negation-as-Failure** (`\+ Goal`): if `purchased(User, Product)` succeeds, `\+ purchased(User, Product)` fails; if it cannot be proven, the negation succeeds.

---

### 3. Project Architecture & Recommendation Logic
**Q8: Why did you choose Prolog over Machine Learning for this recommendation system?**  
*A:* 
1. **Explainability:** Machine learning models are black boxes. In Prolog, every recommendation has a verifiable logical proof tree.
2. **Zero Cold-Start:** Rule-based systems provide accurate recommendations immediately from the very first transaction without requiring thousands of training samples.
3. **Zero Resource Overhead:** Operates with sub-millisecond execution times and minimal memory footprint.

**Q9: How is duplicate recommendation prevented in `recommend_by_category/2`?**  
*A:* The rule specifies `\+ purchased(User, Product)`, ensuring that items already in the customer's purchase history are excluded. Furthermore, the UI uses `setof/3` to aggregate unique product atoms.

**Q10: What is a Dynamic Predicate and why did you use `:- dynamic`?**  
*A:* In ISO Prolog, static clauses cannot be modified at runtime. Declaring `:- dynamic purchased/2.` and `:- dynamic current_user/1.` permits runtime database modification using `assertz/1` (adding facts to the end of the database) and `retractall/1` (removing matching facts), enabling session state tracking and live purchases.

**Q11: How does the Store Placement feature work?**  
*A:* It evaluates `frequently_bought(ProductA, ProductB)` co-purchase associations. When two items exhibit strong basket affinity (like milk with bread, butter, and eggs), the rule generates physical retail placement recommendations to place them near each other in the store.

---

## Project File Structure

```text
Prolog_Project/
│
├── recommendation.pl          # Complete 100% Pure SWI-Prolog Application & UI
├── README.md                  # Comprehensive Academic Documentation & Viva Guide
├── PROJECT_ABSTRACT.txt       # Formal Academic Project Abstract
├── 5_MINUTE_PRESENTATION.txt  # Step-by-Step Viva Presentation Script
├── sample_queries.txt         # Direct Prolog Queries Reference for Evaluators
├── test_cases.txt             # Formal Test Suite with 15 Verified Test Cases
│
├── output/
│   └── sample_output.txt      # 700+ Line Live Terminal Transcript
│
└── screenshots/               # Folder for terminal presentation screenshots
```

---

## Authors & Acknowledgments

- **Developed for:** Academic AI Laboratory Evaluation
- **Paradigm:** Symbolic Artificial Intelligence & Knowledge Representation
- **Engine:** SWI-Prolog (v9.2+)

