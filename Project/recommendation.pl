% ============================================================================
% MASTER PROLOG FILE: recommendation.pl
% Project: Personalized Product Recommendation and Intelligent Store Placement
% AI Paradigm: Symbolic AI / Knowledge Representation & Rule-Based Reasoning
% Language: SWI-Prolog (100% Pure Prolog, No External Dependencies)
% ============================================================================

% Declare dynamic predicates for runtime session state and knowledge updates
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

% Default admin password (change via Admin Panel → option 8)
admin_password('admin123').

% ============================================================================
% 1. USERS
% ============================================================================
user(user1).
user(user2).
user(user3).
user(user4).
user(ram).

% Initial default active user
current_user(user2).

% ============================================================================
% 2. PRODUCT CATEGORIES & CATALOG
% ============================================================================
% Product Catalog IDs
product_id(1,  pizza).
product_id(2,  burger).
product_id(3,  sandwich).
product_id(4,  fries).
product_id(5,  soft_drink).
product_id(6,  mobile).
product_id(7,  laptop).
product_id(8,  milk).
product_id(9,  bread).
product_id(10, butter).
product_id(11, eggs).
product_id(12, mobile_case).
product_id(13, tempered_glass).
product_id(14, charger).
product_id(15, laptop_bag).
product_id(16, mouse).

% Fast Food
category(pizza,      fast_food).
category(burger,     fast_food).
category(sandwich,   fast_food).
category(fries,      fast_food).
category(soft_drink, fast_food).

% Electronics
category(mobile,     electronics).
category(laptop,     electronics).

% Grocery
category(milk,       grocery).
category(bread,      grocery).
category(butter,     grocery).
category(eggs,       grocery).

% Accessories
category(mobile_case,    accessory).
category(tempered_glass, accessory).
category(charger,        accessory).
category(laptop_bag,     accessory).
category(mouse,          accessory).

% Display Formatting: Product Friendly Names
display_name(pizza,          'Pizza').
display_name(burger,         'Burger').
display_name(sandwich,       'Sandwich').
display_name(fries,          'Fries').
display_name(soft_drink,     'Soft Drink').
display_name(mobile,         'Mobile').
display_name(laptop,         'Laptop').
display_name(milk,           'Milk').
display_name(bread,          'Bread').
display_name(butter,         'Butter').
display_name(eggs,           'Eggs').
display_name(mobile_case,    'Mobile Case').
display_name(tempered_glass, 'Tempered Glass').
display_name(charger,        'Charger').
display_name(laptop_bag,     'Laptop Bag').
display_name(mouse,          'Mouse').

% Display Formatting: Category Friendly Names
category_name(fast_food,   'Fast Food').
category_name(electronics, 'Electronics').
category_name(grocery,     'Grocery').
category_name(accessory,   'Accessory').

% ============================================================================
% 3. PRODUCT RELATIONSHIPS & ASSOCIATIONS
% ============================================================================
% Related products (direct complements / accessories)
related(mobile, mobile_case).
related(mobile, tempered_glass).
related(mobile, charger).
related(laptop, laptop_bag).
related(laptop, mouse).

% Frequently bought together (historical co-purchase patterns)
frequently_bought(milk, bread).
frequently_bought(milk, butter).
frequently_bought(milk, eggs).
frequently_bought(mobile, mobile_case).
frequently_bought(mobile, tempered_glass).

% ============================================================================
% 4. CUSTOMER BEHAVIOR & PURCHASE HISTORY (DYNAMIC)
% ============================================================================
% User 1 initial purchase history (Prefers Fast Food)
purchased(user1, pizza).
purchased(user1, burger).
purchased(user1, sandwich).

% User 2 initial purchase history (Electronics buyer)
purchased(user2, mobile).

% User 3 initial purchase history (Grocery shopper)
purchased(user3, milk).

% User Search History
searched(user1, fries).
searched(user1, soft_drink).
searched(user2, mobile_case).
searched(user2, tempered_glass).
searched(user3, bread).

% User Product View History
viewed(user1, fries).
viewed(user1, soft_drink).
viewed(user2, mobile_case).
viewed(user2, charger).
viewed(user3, bread).
viewed(user3, butter).

% ============================================================================
% 5. RECOMMENDATION RULES (LOGICAL INFERENCE)
% ============================================================================

% Rule 1: Preference identification based on category purchases
likes_category(User, Category) :-
    purchased(User, Product),
    category(Product, Category).

% Rule 2: Recommend unpurchased items from preferred category
recommend_by_category(User, Product) :-
    likes_category(User, Category),
    category(Product, Category),
    \+ purchased(User, Product).

% Rule 3: Recommend complementary / related products
recommend_related(User, Product) :-
    purchased(User, BoughtProduct),
    related(BoughtProduct, Product),
    \+ purchased(User, Product).

% Rule 4: Recommend products frequently co-purchased together
recommend_frequently_bought(User, Product) :-
    purchased(User, BoughtProduct),
    frequently_bought(BoughtProduct, Product),
    \+ purchased(User, Product).

% Rule 5: Store placement intelligence suggestion
placement_suggestion(Product1, Product2) :-
    frequently_bought(Product1, Product2).

% ============================================================================
% 6. TERMINAL FORMATTING & DISPLAY HELPERS
% ============================================================================

print_header_box(Title) :-
    format('~n╔══════════════════════════════════════════════════════╗~n'),
    format('║~t~w~t~55|║~n', [Title]),
    format('╚══════════════════════════════════════════════════════╝~n~n').

print_two_line_header(Line1, Line2) :-
    format('~n╔══════════════════════════════════════════════════════╗~n'),
    format('║~t~w~t~55|║~n', [Line1]),
    format('║~t~w~t~55|║~n', [Line2]),
    format('╚══════════════════════════════════════════════════════╝~n~n').

print_three_line_header(Line1, Line2, Line3) :-
    format('~n╔══════════════════════════════════════════════════════╗~n'),
    format('║~t~w~t~55|║~n', [Line1]),
    format('║~t~w~t~55|║~n', [Line2]),
    format('║~t~w~t~55|║~n', [Line3]),
    format('╚══════════════════════════════════════════════════════╝~n~n').

print_divider :-
    format('--------------------------------------------------------~n').

print_double_divider :-
    format('========================================================~n').

% Safe line reader that trims whitespace and returns a string
read_line_clean(CleanStr) :-
    read_line_to_string(user_input, Raw),
    ( Raw == end_of_file ->
        CleanStr = "0"
    ;   normalize_space(string(CleanStr), Raw)
    ).

% Pause prompt waiting for user to press Enter
press_enter :-
    print_divider,
    write('Press Enter to continue...'),
    flush_output,
    read_line_to_string(user_input, _),
    nl.

% Convert product atom to pretty display string
get_product_display(Product, Display) :-
    ( display_name(Product, Display) -> true
    ; atom_string(Product, Display)
    ).

% Convert category atom to pretty display string
get_category_display(Category, Display) :-
    ( category_name(Category, Display) -> true
    ; atom_string(Category, Display)
    ).

% Resolve user input string/number to a valid product atom
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

% Resolve user input string/number to a valid user atom
resolve_user(Input, User) :-
    normalize_space(string(Trimmed), Input),
    Trimmed \== "",
    ( sub_string(Trimmed, _, 1, 0, ".") ->
        sub_string(Trimmed, 0, _, 1, Core)
    ;   Core = Trimmed
    ),
    ( Core == "1" -> User = user1
    ; Core == "2" -> User = user2
    ; Core == "3" -> User = user3
    ; Core == "4" -> User = user4
    ; Core == "5" -> User = ram
    ; downcase_atom(Core, User), user(User)
    ).

% ============================================================================
% 7. INTERACTIVE SCREENS & SUBMENUS
% ============================================================================

% --- SCREEN 1: View Products ---
screen_view_products :-
    print_header_box('PRODUCT CATALOG'),
    format('ID   ~w~t~24| ~w~n', ['PRODUCT', 'CATEGORY']),
    print_divider,
    forall(
        product_id(Id, Prod),
        (
            category(Prod, Cat),
            get_product_display(Prod, ProdName),
            get_category_display(Cat, CatName),
            format('~w~t~5|~w~t~25|~w~n', [Id, ProdName, CatName])
        )
    ),
    print_divider.

% --- SCREEN 2: View Categories ---
screen_view_categories :-
    print_header_box('CATEGORIES'),
    findall(Cat, category(_, Cat), AllCats),
    sort(AllCats, Categories),
    forall(
        member(Category, Categories),
        (
            get_category_display(Category, CatTitle),
            upcase_atom(CatTitle, UpperCatTitle),
            format('~w~n', [UpperCatTitle]),
            forall(
                category(Prod, Category),
                (
                    get_product_display(Prod, PName),
                    format('  • ~w~n', [PName])
                )
            ),
            nl
        )
    ).

% --- SCREEN 3: Select User ---
screen_select_user :-
    print_header_box('SELECT USER'),
    % Dynamically list all known users with numbers
    findall(U, user(U), AllUsers),
    forall(
        nth1(Idx, AllUsers, U),
        format('[~w] ~w~n', [Idx, U])
    ),
    nl,
    write('Enter user number or name: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( resolve_user_dynamic(Input, AllUsers, SelectedUser) ->
        retractall(current_user(_)),
        assertz(current_user(SelectedUser)),
        writeln('✓ User selected successfully.'),
        nl,
        format('Current User: ~w~n', [SelectedUser])
    ;   writeln('✗ Invalid user. Please try again.')
    ).

% Resolve user from dynamic list by index or name
resolve_user_dynamic(Input, AllUsers, User) :-
    normalize_space(string(Trimmed), Input),
    Trimmed \== "",
    ( number_string(N, Trimmed),
      integer(N),
      nth1(N, AllUsers, User)
    -> true
    ; downcase_atom(Trimmed, LowerAtom),
      member(User, AllUsers),
      downcase_atom(User, LowerAtom)
    ).

% --- SCREEN: Add New User ---
screen_add_new_user :-
    print_header_box('ADD NEW USER'),
    writeln('Existing Users:'),
    findall(U, user(U), AllUsers),
    forall(member(U, AllUsers), format('  • ~w~n', [U])),
    nl,
    write('Enter new user name: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✗ No name entered. Operation cancelled.')
    ;   normalize_space(atom(NewUser), Input),
        ( user(NewUser) ->
            format('✗ User "~w" already exists.~n', [NewUser])
        ;   assertz(user(NewUser)),
            retractall(current_user(_)),
            assertz(current_user(NewUser)),
            format('✓ New user "~w" created and set as active user.~n', [NewUser]),
            nl,
            new_user_menu_loop(NewUser)
        )
    ).

% ─────────────────────────────────────────────────────
% NEW USER SUB-MENU (dynamic menu shown after creation)
% ─────────────────────────────────────────────────────
display_new_user_menu(User) :-
    findall(P, purchased(User, P), Cart),
    length(Cart, CartCount),
    print_double_divider,
    format('  NEW USER MENU  —  Current User: ~w~n', [User]),
    print_double_divider,
    nl,
    format('[1] Add Product to Cart  (Cart: ~w item(s))~n', [CartCount]),
    writeln('[2] View Cart'),
    writeln('[3] Get Personalized Recommendations'),
    writeln('[0] Back to Main Menu'),
    nl,
    print_divider.

new_user_menu_loop(User) :-
    display_new_user_menu(User),
    write('Enter choice: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "1" ->
        screen_new_user_add_to_cart(User),
        press_enter,
        new_user_menu_loop(User)
    ; Input == "2" ->
        screen_new_user_view_cart(User),
        press_enter,
        new_user_menu_loop(User)
    ; Input == "3" ->
        screen_new_user_recommendations(User),
        press_enter,
        new_user_menu_loop(User)
    ; Input == "0" ->
        writeln('Returning to Main Menu...')
    ;   writeln('✗ Invalid choice. Enter 0, 1, 2 or 3.'),
        nl,
        new_user_menu_loop(User)
    ).

% [1] Add Product to Cart sub-screen
screen_new_user_add_to_cart(User) :-
    print_header_box('ADD TO CART'),
    format('User: ~w~n~n', [User]),
    writeln('Available Products (type name or ID):'),
    print_divider,
    forall(
        product_id(Id, Prod),
        (
            get_product_display(Prod, PName),
            category(Prod, Cat),
            get_category_display(Cat, CatName),
            ( purchased(User, Prod) ->
                format('  ~w. ~w  (~w)  [in cart]~n', [Id, PName, CatName])
            ;   format('  ~w. ~w  (~w)~n', [Id, PName, CatName])
            )
        )
    ),
    print_divider,
    nl,
    cart_add_loop(User).

% Loop: keep adding products until user presses Enter or types 0
cart_add_loop(User) :-
    write('Add product (name/ID, 0 to finish): '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✓ Done adding products.')
    ; Input == "0" ->
        writeln('✓ Done adding products.')
    ; resolve_product(Input, Product) ->
        ( purchased(User, Product) ->
            get_product_display(Product, PName),
            format('ℹ "~w" is already in your cart.~n~n', [PName]),
            cart_add_loop(User)
        ;   assertz(purchased(User, Product)),
            get_product_display(Product, PName),
            category(Product, Cat),
            get_category_display(Cat, CatName),
            format('  ✓ Added: ~w  (~w)~n~n', [PName, CatName]),
            cart_add_loop(User)
        )
    ;   % Unknown product — check if it was a number (bad ID) or a name (create it)
        normalize_space(atom(NewProduct), Input),
        ( number_string(_, Input) ->
            % It was a number but didn't match any product_id → invalid ID
            format('✗ "~w" is not a valid product ID. Enter a name or a valid ID (1–16).~n~n',
                   [NewProduct]),
            cart_add_loop(User)
        ;   % It's a text name not in catalog → offer to create it
            format('ℹ "~w" is not in the catalog.~n', [NewProduct]),
            writeln('  Select category:  [1] fast_food  [2] electronics  [3] grocery  [4] accessory'),
            writeln('  (or press Enter to cancel)'),
            write('  Category: '),
            flush_output,
            read_line_clean(CatInput),
            nl,
            ( CatInput == "" ->
                writeln('  Cancelled. Product not added.'),
                nl,
                cart_add_loop(User)
            ; resolve_category(CatInput, NewCat) ->
                findall(Id, product_id(Id, _), Ids),
                ( Ids == [] -> NextId = 1 ; max_list(Ids, MaxId), NextId is MaxId + 1 ),
                assertz(product_id(NextId, NewProduct)),
                assertz(category(NewProduct, NewCat)),
                assertz(display_name(NewProduct, NewProduct)),
                assertz(purchased(User, NewProduct)),
                format('  ✓ New product "~w" created & added to cart (Category: ~w)~n~n',
                       [NewProduct, NewCat]),
                cart_add_loop(User)
            ;   writeln('  ✗ Invalid category. Product skipped.'),
                nl,
                cart_add_loop(User)
            )
        )
    ).

% [2] View Cart sub-screen
screen_new_user_view_cart(User) :-
    print_header_box('YOUR CART'),
    format('User: ~w~n~n', [User]),
    findall(P, purchased(User, P), Cart),
    ( Cart == [] ->
        writeln('ℹ Your cart is empty. Use option 1 to add products.')
    ;   length(Cart, Count),
        format('~w item(s) in cart:~n~n', [Count]),
        print_divider,
        forall(
            nth1(Idx, Cart, Item),
            (
                get_product_display(Item, IName),
                category(Item, Cat),
                get_category_display(Cat, CatName),
                format('  ~w. ~w  (~w)~n', [Idx, IName, CatName])
            )
        ),
        print_divider
    ).

% [3] Personalized Recommendations sub-screen
screen_new_user_recommendations(User) :-
    print_header_box('PERSONALIZED RECOMMENDATIONS'),
    format('Customer: ~w~n~n', [User]),
    findall(P, purchased(User, P), Purchases),
    ( Purchases == [] ->
        writeln('ℹ Your cart is empty!'),
        writeln('Please add products first (option 1) to get recommendations.')
    ;   writeln('Based on your cart:'),
        forall(
            member(PI, Purchases),
            (
                get_product_display(PI, PIName),
                format('  • ~w~n', [PIName])
            )
        ),
        nl,
        findall(Cat, likes_category(User, Cat), AllCats),
        sort(AllCats, DetectedCats),
        writeln('Detected Preferences:'),
        forall(
            member(DC, DetectedCats),
            (
                get_category_display(DC, DCName),
                upcase_atom(DCName, UpperDC),
                format('  → ~w~n', [UpperDC])
            )
        ),
        nl,
        ( setof(Rec, recommend_by_category(User, Rec), Recs) ->
            writeln('Recommended Products for You:'),
            print_divider,
            print_numbered_items(Recs, 1),
            print_divider,
            nl,
            writeln('Inference Chain:'),
            writeln('  purchased → category detected → preference inferred → recommendation')
        ;   writeln('ℹ All products in your preferred categories have been purchased!')
        )
    ).

% --- SCREEN 4: View Purchase History ---
screen_view_purchase_history :-
    current_user(CurrentUser),
    print_header_box('PURCHASE HISTORY'),
    format('Customer: ~w~n~n', [CurrentUser]),
    findall(P, purchased(CurrentUser, P), Purchases),
    ( Purchases == [] ->
        writeln('ℹ No purchases recorded for this user yet.')
    ;   writeln('Purchased Products:'),
        forall(
            member(Item, Purchases),
            (
                get_product_display(Item, ItemName),
                category(Item, Cat),
                get_category_display(Cat, CatName),
                format('• ~w (~w)~n', [ItemName, CatName])
            )
        )
    ).

% --- SCREEN 5: Purchase Product & Real-Time Recommendations ---
screen_purchase_product :-
    current_user(CurrentUser),
    print_header_box('PURCHASE PRODUCT'),
    format('Current User: ~w~n~n', [CurrentUser]),
    write('Enter product (name or ID): '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✗ Purchase cancelled. No product entered.')
    ; resolve_product(Input, Product) ->
        ( purchased(CurrentUser, Product) ->
            writeln('ℹ This product already exists in the user\'s purchase history.')
        ;   assertz(purchased(CurrentUser, Product)),
            writeln('✓ Purchase successful.'),
            nl,
            format('User: ~w~n', [CurrentUser]),
            format('Product: ~w~n', [Product]),
            trigger_realtime_recommendations(CurrentUser, Product)
        )
    ;   % Product not found — offer to add it dynamically
        normalize_space(atom(NewProduct), Input),
        format('ℹ Product "~w" is not in the catalog.~n', [NewProduct]),
        nl,
        writeln('Available categories:'),
        writeln('  [1] fast_food'),
        writeln('  [2] electronics'),
        writeln('  [3] grocery'),
        writeln('  [4] accessory'),
        nl,
        write('Select category (number or name): '),
        flush_output,
        read_line_clean(CatInput),
        nl,
        ( resolve_category(CatInput, NewCategory) ->
            % Assign next product ID
            findall(Id, product_id(Id, _), Ids),
            ( Ids == [] -> NextId = 1 ; max_list(Ids, MaxId), NextId is MaxId + 1 ),
            % Register the new product facts
            assertz(product_id(NextId, NewProduct)),
            assertz(category(NewProduct, NewCategory)),
            assertz(display_name(NewProduct, NewProduct)),
            % Record the purchase
            assertz(purchased(CurrentUser, NewProduct)),
            format('✓ New product "~w" added to catalog (ID: ~w, Category: ~w).~n',
                   [NewProduct, NextId, NewCategory]),
            nl,
            format('✓ Purchase of "~w" recorded for user ~w.~n', [NewProduct, CurrentUser]),
            nl,
            trigger_realtime_recommendations(CurrentUser, NewProduct)
        ;   writeln('✗ Invalid category. Purchase cancelled.')
        )
    ).

% Resolve category input (number 1-4 or name string)
resolve_category(Input, Category) :-
    normalize_space(string(T), Input),
    ( T == "1" -> Category = fast_food
    ; T == "2" -> Category = electronics
    ; T == "3" -> Category = grocery
    ; T == "4" -> Category = accessory
    ; downcase_atom(T, CA),
      member(Category, [fast_food, electronics, grocery, accessory]),
      Category = CA
    ).

% Sub-routine: Real-Time Recommendation after Purchase
trigger_realtime_recommendations(User, PurchasedProduct) :-
    get_product_display(PurchasedProduct, PName),
    print_header_box('RECOMMENDATIONS GENERATED'),
    writeln('You purchased:'),
    format('→ ~w~n~n', [PName]),
    % Gather related products
    findall(R, (related(PurchasedProduct, R), \+ purchased(User, R)), RelatedRecs),
    % Gather frequently bought products
    findall(F, (frequently_bought(PurchasedProduct, F), \+ purchased(User, F), \+ member(F, RelatedRecs)), FreqRecs),
    append(RelatedRecs, FreqRecs, DirectRecs),
    ( DirectRecs \== [] ->
        writeln('Recommended for you:'),
        nl,
        print_numbered_items(DirectRecs, 1),
        nl,
        writeln('Why?'),
        nl,
        forall(
            member(RelItem, RelatedRecs),
            (
                get_product_display(RelItem, RelName),
                format('~w~n→ Related to ~w~n~n', [RelName, PName])
            )
        ),
        forall(
            member(FreqItem, FreqRecs),
            (
                get_product_display(FreqItem, FreqName),
                format('~w~n→ Frequently bought together with ~w~n~n', [FreqName, PName])
            )
        ),
        writeln('✓ Recommendations generated using Prolog rules.')
    ;   % Fallback to category recommendation if no direct associations
        setof(CRec, recommend_by_category(User, CRec), CatRecs) ->
        writeln('Recommended for you (Based on Category Preferences):'),
        nl,
        print_numbered_items(CatRecs, 1),
        nl,
        writeln('Why?'),
        nl,
        category(PurchasedProduct, Cat),
        get_category_display(Cat, CatName),
        forall(
            member(CR, CatRecs),
            (
                get_product_display(CR, CRName),
                format('~w~n→ In your preferred category (~w)~n~n', [CRName, CatName])
            )
        ),
        writeln('✓ Recommendations generated using Prolog rules.')
    ;   writeln('ℹ No recommendation is currently available.')
    ).

print_numbered_items([], _).
print_numbered_items([Item|Rest], N) :-
    get_product_display(Item, DisplayName),
    format('  ~w. ~w~n', [N, DisplayName]),
    Next is N + 1,
    print_numbered_items(Rest, Next).

% --- SCREEN 6: Personalized Recommendations ---
screen_personalized_recommendations :-
    current_user(CurrentUser),
    print_header_box('PERSONALIZED RECOMMENDATIONS'),
    format('Customer: ~w~n~n', [CurrentUser]),
    findall(P, purchased(CurrentUser, P), Purchases),
    ( Purchases == [] ->
        writeln('Purchase History: None'),
        nl,
        writeln('ℹ No purchase history available for personalized recommendations.'),
        writeln('Please purchase a product first.')
    ;   writeln('Purchase History:'),
        forall(
            member(PurchasedItem, Purchases),
            (
                get_product_display(PurchasedItem, ItemName),
                format('• ~w~n', [ItemName])
            )
        ),
        nl,
        findall(Cat, likes_category(CurrentUser, Cat), AllCats),
        sort(AllCats, DetectedCats),
        writeln('Detected Preference:'),
        forall(
            member(DC, DetectedCats),
            (
                get_category_display(DC, DCName),
                upcase_atom(DCName, UpperDCName),
                format('→ ~w~n', [UpperDCName])
            )
        ),
        nl,
        ( setof(RecProd, recommend_by_category(CurrentUser, RecProd), Recs) ->
            writeln('Recommended Products:'),
            print_divider,
            print_numbered_items(Recs, 1),
            print_divider,
            nl,
            writeln('Reason:'),
            ( DetectedCats = [FirstCat|_] ->
                get_category_display(FirstCat, PrefName),
                format('The customer purchased multiple products from the~n~w category.~n', [PrefName])
            ;   writeln('The customer purchased products matching these categories.')
            ),
            nl,
            writeln('Inference:'),
            writeln('purchased → category → preference → recommendation')
        ;   writeln('Recommended Products:'),
            print_divider,
            writeln('ℹ All products in preferred category have already been purchased.'),
            print_divider
        )
    ).

% --- SCREEN 7: Related Product Recommendations ---
screen_related_products :-
    current_user(CurrentUser),
    print_header_box('RELATED PRODUCT ENGINE'),
    % Find products purchased by current user that have related products
    findall(Bought, (purchased(CurrentUser, Bought), related(Bought, _)), EligibleBoughtList),
    sort(EligibleBoughtList, UniqueEligible),
    ( UniqueEligible = [TargetProduct|_] ->
        DefaultProduct = TargetProduct
    ;   DefaultProduct = mobile
    ),
    get_product_display(DefaultProduct, DefProdName),
    format('Purchased Product:~n→ ~w~n~n', [DefProdName]),
    findall(Rel, related(DefaultProduct, Rel), RelatedProducts),
    ( RelatedProducts \== [] ->
        writeln('Related Products:'),
        print_divider,
        print_numbered_items(RelatedProducts, 1),
        print_divider,
        nl,
        writeln('Logic:'),
        format('related(~w, Product)~n~n', [DefaultProduct]),
        writeln('✓ Recommendation generated using Prolog inference.')
    ;   writeln('ℹ No related products found for this item in the knowledge base.')
    ).

% --- SCREEN 8: Frequently Bought Together ---
screen_frequently_bought :-
    current_user(CurrentUser),
    print_header_box('FREQUENTLY BOUGHT TOGETHER'),
    % Identify if current user purchased an item with co-purchase facts
    findall(B, (purchased(CurrentUser, B), frequently_bought(B, _)), CoBoughtList),
    sort(CoBoughtList, UniqueCoBought),
    ( UniqueCoBought = [TargetProduct|_] ->
        DefaultProduct = TargetProduct
    ;   DefaultProduct = milk
    ),
    get_product_display(DefaultProduct, DefName),
    format('Product:~n→ ~w~n~n', [DefName]),
    findall(Other, frequently_bought(DefaultProduct, Other), FreqList),
    ( FreqList \== [] ->
        writeln('Frequently Bought Together:'),
        print_divider,
        print_numbered_items(FreqList, 1),
        print_divider,
        nl,
        writeln('Reason:'),
        writeln('These products have a predefined historical'),
        writeln('co-purchase relationship.'),
        nl,
        writeln('✓ Association identified using Prolog facts.')
    ;   writeln('ℹ No co-purchase relationships registered for this item.')
    ).

% --- SCREEN 9: Store Placement Suggestions ---
screen_store_placement :-
    print_header_box('STORE PLACEMENT INTELLIGENCE'),
    writeln('PRODUCT ASSOCIATIONS'),
    nl,
    format('~w~t~16|~w~t~32|~w~n', ['PRODUCT A', 'PRODUCT B', 'RELATION']),
    print_divider,
    findall(pair(A, B), frequently_bought(A, B), Associations),
    forall(
        member(pair(P1, P2), Associations),
        (
            get_product_display(P1, Name1),
            get_product_display(P2, Name2),
            format('~w~t~16|~w~t~32|Frequently Bought~n', [Name1, Name2])
        )
    ),
    print_divider,
    nl,
    writeln('PLACEMENT OPPORTUNITIES'),
    nl,
    forall(
        member(pair(Prod1, Prod2), Associations),
        (
            get_product_display(Prod1, D1),
            get_product_display(Prod2, D2),
            format('→ Consider placing ~w near ~w.~n', [D2, D1])
        )
    ),
    nl,
    writeln('Note:'),
    writeln('These are potential placement opportunities based on'),
    writeln('historical co-purchase relationships. They do not'),
    writeln('guarantee increased sales.').

% --- SCREEN 10: Explain Recommendation (Explainable AI) ---
screen_explain_recommendation :-
    current_user(CurrentUser),
    print_header_box('WHY THIS RECOMMENDATION?'),
    format('User:~n~w~n~n', [CurrentUser]),
    % Check for related recommendation explanation
    ( (purchased(CurrentUser, Bought), related(Bought, Rec), \+ purchased(CurrentUser, Rec)) ->
        get_product_display(Rec, RecName),
        get_product_display(Bought, BoughtName),
        format('Recommendation:~n~w~n~n', [RecName]),
        format('Reason:~nYou purchased ~w.~n~n', [BoughtName]),
        format('Knowledge:~nrelated(~w, ~w).~n~n', [Bought, Rec]),
        writeln('Inference:'),
        format('Purchased ~w~n', [BoughtName]),
        writeln('       ↓'),
        writeln('Related Product'),
        writeln('       ↓'),
        format('~w~n', [RecName]),
        writeln('       ↓'),
        writeln('Recommendation'),
        nl,
        writeln('✓ Explanation generated from Prolog knowledge.')
    % Check for category recommendation explanation
    ; (likes_category(CurrentUser, Cat), category(CatRec, Cat), \+ purchased(CurrentUser, CatRec)) ->
        get_product_display(CatRec, RecName),
        get_category_display(Cat, CatName),
        format('Recommendation:~n~w~n~n', [RecName]),
        format('Reason:~nYou purchased products from the ~w category.~n~n', [CatName]),
        format('Knowledge:~ncategory(..., ~w), category(~w, ~w).~n~n', [Cat, CatRec, Cat]),
        writeln('Inference:'),
        format('Purchased Products in ~w~n', [CatName]),
        writeln('       ↓'),
        writeln('Category Preference Inferred'),
        writeln('       ↓'),
        format('~w (~w)~n', [RecName, CatName]),
        writeln('       ↓'),
        writeln('Recommendation'),
        nl,
        writeln('✓ Explanation generated from Prolog knowledge.')
    % Check for frequently bought co-purchase explanation
    ; (purchased(CurrentUser, Bought), frequently_bought(Bought, FreqRec), \+ purchased(CurrentUser, FreqRec)) ->
        get_product_display(FreqRec, RecName),
        get_product_display(Bought, BoughtName),
        format('Recommendation:~n~w~n~n', [RecName]),
        format('Reason:~nYou purchased ~w.~n~n', [BoughtName]),
        format('Knowledge:~nfrequently_bought(~w, ~w).~n~n', [Bought, FreqRec]),
        writeln('Inference:'),
        format('Purchased ~w~n', [BoughtName]),
        writeln('       ↓'),
        writeln('Frequently Bought Together'),
        writeln('       ↓'),
        format('~w~n', [RecName]),
        writeln('       ↓'),
        writeln('Recommendation'),
        nl,
        writeln('✓ Explanation generated from Prolog knowledge.')
    ;   writeln('ℹ No active recommendations available to explain for this user.')
    ).

% --- SCREEN 11: Backtracking Demonstration ---
screen_backtracking_demo :-
    print_header_box('BACKTRACKING DEMO'),
    writeln('Query:'),
    nl,
    writeln('?- recommend_related(user2, Product).'),
    nl,
    writeln('Prolog searches the knowledge base...'),
    nl,
    findall(P, recommend_related(user2, P), Solutions),
    print_backtrack_steps(Solutions, 1),
    writeln('No more solutions.'),
    nl,
    writeln('false.'),
    nl,
    print_divider,
    writeln('CONCEPT:'),
    writeln('Prolog uses backtracking to search for alternative'),
    writeln('valid solutions across clauses in the knowledge base.'),
    print_divider.

print_backtrack_steps([], _).
print_backtrack_steps([Sol|Rest], Idx) :-
    format('Solution ~w:~nProduct = ~w~n~n', [Idx, Sol]),
    Next is Idx + 1,
    print_backtrack_steps(Rest, Next).

% --- SCREEN 12: System Information ---
screen_system_info :-
    print_header_box('SYSTEM INFORMATION'),
    writeln('Project:'),
    writeln('Personalized Product Recommendation System'),
    nl,
    writeln('AI Approach:'),
    writeln('Symbolic AI / Rule-Based AI'),
    nl,
    writeln('Language:'),
    writeln('Prolog'),
    nl,
    writeln('Engine:'),
    writeln('SWI-Prolog'),
    nl,
    writeln('Machine Learning:'),
    writeln('Not Used'),
    nl,
    writeln('Database:'),
    writeln('Not Used'),
    nl,
    writeln('Web Framework:'),
    writeln('Not Used'),
    nl,
    writeln('Core Concepts:'),
    writeln('• Knowledge Representation'),
    writeln('• Facts'),
    writeln('• Rules'),
    writeln('• Queries'),
    writeln('• Unification'),
    writeln('• Logical Inference'),
    writeln('• Backtracking'),
    writeln('• Explainable Reasoning').

% ============================================================================
% 8. MAIN MENU & CONTROLLER LOOP
% ============================================================================

% Home / Splash Screen
screen_splash :-
    print_three_line_header(
        'PERSONALIZED PRODUCT RECOMMENDATION',
        '& INTELLIGENT STORE PLACEMENT SYSTEM',
        'PROLOG'
    ),
    writeln('AI LAB PROJECT'),
    writeln('Symbolic AI | Rule-Based Recommendation'),
    nl,
    writeln('Features:'),
    writeln('✓ Personalized Recommendations'),
    writeln('✓ Related Product Recommendation'),
    writeln('✓ Frequently Bought Together'),
    writeln('✓ Explainable AI'),
    writeln('✓ Dynamic User & Admin Panel'),
    nl,
    print_divider,
    write('Press Enter to continue...'),
    flush_output,
    read_line_to_string(user_input, _),
    nl.

% Main Menu Rendering
display_main_menu :-
    current_user(CurrentUser),
    print_double_divider,
    format('~t~w~t~56|~n', ['MAIN MENU']),
    print_double_divider,
    nl,
    writeln('[1] View Products'),
    writeln('[2] View Categories'),
    writeln('[3] Select User'),
    writeln('[4] View Purchase History'),
    writeln('[5] Purchase Product'),
    writeln('[6] Personalized Recommendations'),
    writeln('[7] Related Product Recommendations'),
    writeln('[8] Frequently Bought Together'),
    writeln('[9] Explain Recommendation'),
    writeln('[10] System Information'),
    writeln('[11] Add New User'),
    writeln('[12] Admin Panel'),
    writeln('[0] Exit'),
    nl,
    print_divider,
    format('Current User: ~w~n', [CurrentUser]),
    print_divider,
    nl.

% Main execution loop
main_menu_loop :-
    display_main_menu,
    write('Enter choice: '),
    flush_output,
    read_line_clean(Input),
    ( sub_string(Input, _, 1, 0, ".") ->
        sub_string(Input, 0, _, 1, CleanInput)
    ;   CleanInput = Input
    ),
    ( CleanInput == "0" ->
        nl,
        print_header_box('THANK YOU FOR USING THE AI SYSTEM!'),
        writeln('Application terminated cleanly. Goodbye!'),
        nl
    ; CleanInput == "1" ->
        screen_view_products,
        press_enter,
        main_menu_loop
    ; CleanInput == "2" ->
        screen_view_categories,
        press_enter,
        main_menu_loop
    ; CleanInput == "3" ->
        screen_select_user,
        press_enter,
        main_menu_loop
    ; CleanInput == "4" ->
        screen_view_purchase_history,
        press_enter,
        main_menu_loop
    ; CleanInput == "5" ->
        screen_purchase_product,
        press_enter,
        main_menu_loop
    ; CleanInput == "6" ->
        screen_personalized_recommendations,
        press_enter,
        main_menu_loop
    ; CleanInput == "7" ->
        screen_related_products,
        press_enter,
        main_menu_loop
    ; CleanInput == "8" ->
        screen_frequently_bought,
        press_enter,
        main_menu_loop
    ; CleanInput == "9" ->
        screen_explain_recommendation,
        press_enter,
        main_menu_loop
    ; CleanInput == "10" ->
        screen_system_info,
        press_enter,
        main_menu_loop
    ; CleanInput == "11" ->
        screen_add_new_user,
        press_enter,
        main_menu_loop
    ; CleanInput == "12" ->
        screen_admin_login,
        main_menu_loop
    ;   nl,
        writeln('✗ Invalid choice.'),
        nl,
        writeln('Please enter a number from 0 to 12.'),
        press_enter,
        main_menu_loop
    ).

% ============================================================================
% 9. ADMIN PANEL
% ============================================================================

% --- Admin Login Screen ---
screen_admin_login :-
    print_header_box('ADMIN PANEL LOGIN'),
    write('Enter admin password: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( admin_password(Input) ->
        writeln('✓ Login successful. Welcome, Admin!'),
        nl,
        admin_menu_loop
    ;   writeln('✗ Incorrect password. Access denied.')
    ).

% --- Admin Sub-Menu Display ---
display_admin_menu :-
    print_double_divider,
    format('~t~w~t~56|~n', ['ADMIN PANEL']),
    print_double_divider,
    nl,
    writeln('[1] View All Products'),
    writeln('[2] Add New Product'),
    writeln('[3] Edit Product Category'),
    writeln('[4] Delete Product'),
    writeln('[5] View All Users'),
    writeln('[6] View User Purchase History'),
    writeln('[7] Add New User'),
    writeln('[8] Change Admin Password'),
    writeln('[0] Exit Admin Panel'),
    nl,
    print_divider,
    nl.

% --- Admin Menu Loop ---
admin_menu_loop :-
    display_admin_menu,
    write('Admin choice: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "0" ->
        writeln('Exiting Admin Panel...')
    ; Input == "1" ->
        admin_view_products,
        press_enter,
        admin_menu_loop
    ; Input == "2" ->
        admin_add_product,
        press_enter,
        admin_menu_loop
    ; Input == "3" ->
        admin_edit_product,
        press_enter,
        admin_menu_loop
    ; Input == "4" ->
        admin_delete_product,
        press_enter,
        admin_menu_loop
    ; Input == "5" ->
        admin_view_users,
        press_enter,
        admin_menu_loop
    ; Input == "6" ->
        admin_view_user_history,
        press_enter,
        admin_menu_loop
    ; Input == "7" ->
        admin_add_user,
        press_enter,
        admin_menu_loop
    ; Input == "8" ->
        admin_change_password,
        press_enter,
        admin_menu_loop
    ;   writeln('✗ Invalid choice. Enter 0 to 8.'),
        nl,
        admin_menu_loop
    ).

% ─── [1] View All Products ────────────────────────────────────────────────────
admin_view_products :-
    print_header_box('ADMIN — ALL PRODUCTS'),
    format('~w~t~5|~w~t~25|~w~t~42|~n', ['ID', 'PRODUCT', 'CATEGORY']),
    print_divider,
    ( \+ product_id(_, _) ->
        writeln('ℹ No products in catalog.')
    ;   forall(
            product_id(Id, Prod),
            (
                get_product_display(Prod, PName),
                ( category(Prod, Cat) ->
                    get_category_display(Cat, CatName)
                ;   CatName = 'N/A'
                ),
                format('~w~t~5|~w~t~25|~w~n', [Id, PName, CatName])
            )
        )
    ),
    print_divider,
    findall(_, product_id(_, _), Ps), length(Ps, Total),
    format('Total: ~w product(s)~n', [Total]).

% ─── [2] Add New Product ──────────────────────────────────────────────────────
admin_add_product :-
    print_header_box('ADMIN — ADD NEW PRODUCT'),
    write('Product name: '),
    flush_output,
    read_line_clean(NameInput),
    nl,
    ( NameInput == "" ->
        writeln('✗ No name entered. Cancelled.')
    ;   normalize_space(atom(NewProd), NameInput),
        ( category(NewProd, _) ->
            format('✗ Product "~w" already exists.~n', [NewProd])
        ;   writeln('Select category:'),
            writeln('  [1] fast_food  [2] electronics  [3] grocery  [4] accessory'),
            write('Category: '),
            flush_output,
            read_line_clean(CatInput),
            nl,
            ( resolve_category(CatInput, NewCat) ->
                findall(Id, product_id(Id, _), Ids),
                ( Ids == [] -> NextId = 1 ; max_list(Ids, MaxId), NextId is MaxId + 1 ),
                assertz(product_id(NextId, NewProd)),
                assertz(category(NewProd, NewCat)),
                assertz(display_name(NewProd, NewProd)),
                format('✓ Product "~w" added (ID: ~w, Category: ~w).~n',
                       [NewProd, NextId, NewCat])
            ;   writeln('✗ Invalid category. Cancelled.')
            )
        )
    ).

% ─── [3] Edit Product Category ───────────────────────────────────────────────
admin_edit_product :-
    print_header_box('ADMIN — EDIT PRODUCT CATEGORY'),
    admin_view_products,
    nl,
    write('Enter product name or ID to edit: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✗ Cancelled.')
    ; resolve_product(Input, Prod) ->
        category(Prod, OldCat),
        get_product_display(Prod, PName),
        format('Product: ~w  |  Current Category: ~w~n~n', [PName, OldCat]),
        writeln('New category:'),
        writeln('  [1] fast_food  [2] electronics  [3] grocery  [4] accessory'),
        write('Category: '),
        flush_output,
        read_line_clean(CatInput),
        nl,
        ( CatInput == "" ->
            writeln('✗ Cancelled. No changes made.')
        ; resolve_category(CatInput, NewCat) ->
            retract(category(Prod, OldCat)),
            assertz(category(Prod, NewCat)),
            format('✓ Category of "~w" updated: ~w → ~w~n', [PName, OldCat, NewCat])
        ;   writeln('✗ Invalid category. No changes made.')
        )
    ;   writeln('✗ Product not found.')
    ).

% ─── [4] Delete Product ───────────────────────────────────────────────────────
admin_delete_product :-
    print_header_box('ADMIN — DELETE PRODUCT'),
    admin_view_products,
    nl,
    write('Enter product name or ID to delete: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✗ Cancelled.')
    ; resolve_product(Input, Prod) ->
        get_product_display(Prod, PName),
        format('Delete "~w"? Type YES to confirm: ', [PName]),
        flush_output,
        read_line_clean(Confirm),
        nl,
        ( Confirm == "YES" ->
            retractall(product_id(_, Prod)),
            retractall(category(Prod, _)),
            retractall(display_name(Prod, _)),
            retractall(purchased(_, Prod)),
            retractall(related(Prod, _)),
            retractall(related(_, Prod)),
            retractall(frequently_bought(Prod, _)),
            retractall(frequently_bought(_, Prod)),
            format('✓ Product "~w" and all associated data deleted.~n', [PName])
        ;   writeln('✗ Cancelled. Product not deleted.')
        )
    ;   writeln('✗ Product not found.')
    ).

% ─── [5] View All Users ───────────────────────────────────────────────────────
admin_view_users :-
    print_header_box('ADMIN — ALL USERS'),
    findall(U, user(U), Users),
    ( Users == [] ->
        writeln('ℹ No users found.')
    ;   length(Users, Total),
        format('Total Users: ~w~n~n', [Total]),
        print_divider,
        forall(
            nth1(Idx, Users, U),
            (
                findall(P, purchased(U, P), Purchases),
                length(Purchases, PCount),
                format('~w. ~w  (~w purchase(s))~n', [Idx, U, PCount])
            )
        ),
        print_divider
    ).

% ─── [6] View User Purchase History ──────────────────────────────────────────
admin_view_user_history :-
    print_header_box('ADMIN — USER PURCHASE HISTORY'),
    findall(U, user(U), Users),
    forall(nth1(I, Users, U), format('[~w] ~w~n', [I, U])),
    nl,
    write('Select user (number or name): '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( resolve_user_dynamic(Input, Users, TargetUser) ->
        format('Purchase History for: ~w~n~n', [TargetUser]),
        findall(P, purchased(TargetUser, P), Purchases),
        ( Purchases == [] ->
            writeln('ℹ No purchases recorded.')
        ;   print_divider,
            forall(
                nth1(Idx, Purchases, Item),
                (
                    get_product_display(Item, IName),
                    ( category(Item, Cat) ->
                        get_category_display(Cat, CatName)
                    ;   CatName = 'N/A'
                    ),
                    format('  ~w. ~w  (~w)~n', [Idx, IName, CatName])
                )
            ),
            print_divider,
            length(Purchases, PCount),
            format('Total: ~w item(s)~n', [PCount])
        )
    ;   writeln('✗ Invalid user.')
    ).

% ─── [7] Add New User (Admin) ────────────────────────────────────────────────
admin_add_user :-
    print_header_box('ADMIN — ADD NEW USER'),
    findall(U, user(U), AllUsers),
    writeln('Existing users:'),
    forall(member(U, AllUsers), format('  • ~w~n', [U])),
    nl,
    write('New user name: '),
    flush_output,
    read_line_clean(Input),
    nl,
    ( Input == "" ->
        writeln('✗ Cancelled.')
    ;   normalize_space(atom(NewUser), Input),
        ( user(NewUser) ->
            format('✗ User "~w" already exists.~n', [NewUser])
        ;   assertz(user(NewUser)),
            format('✓ User "~w" added to the system.~n', [NewUser])
        )
    ).

% ─── [8] Change Admin Password ───────────────────────────────────────────────
admin_change_password :-
    print_header_box('ADMIN — CHANGE PASSWORD'),
    write('Current password: '),
    flush_output,
    read_line_clean(Current),
    nl,
    ( admin_password(Current) ->
        write('New password: '),
        flush_output,
        read_line_clean(New1),
        nl,
        write('Confirm new password: '),
        flush_output,
        read_line_clean(New2),
        nl,
        ( New1 == "" ->
            writeln('✗ Password cannot be empty.')
        ; New1 == New2 ->
            retractall(admin_password(_)),
            assertz(admin_password(New1)),
            writeln('✓ Admin password changed successfully.')
        ;   writeln('✗ Passwords do not match. No changes made.')
        )
    ;   writeln('✗ Current password incorrect. No changes made.')
    ).

% ============================================================================
% 10. ENTRY POINT
% ============================================================================

% Entry Point Predicate
start :-
    screen_splash,
    main_menu_loop.