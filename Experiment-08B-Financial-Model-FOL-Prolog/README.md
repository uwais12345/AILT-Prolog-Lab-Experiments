# Experiment 8B – Financial Model Using FOL and Prolog

## Aim

To represent financial investment knowledge using First-Order Logic, convert the statements into clause form, and implement the knowledge base in Prolog for logical inference and unification.

## Algorithm

1. Define financial facts such as bonds and gold as safe assets.
2. Define the rule that trusts every safe asset.
3. Define the rule that an investment is safe if the investor has not lost money from it.
4. Define that Lingam invests in stock.
5. Define that Aral invests in everything Lingam invests in.
6. Implement the clauses as Prolog facts and rules.
7. Query the knowledge base using Prolog.
8. Display the inferred safe investments and trust relationships.

## Program

```prolog
safe(bonds).
safe(gold).

invests(lingam,stock).

invests(aral,X) :-
    invests(lingam,X).

safe(X) :-
    invests(_,X),
    \+ lost(_,X).

trusts(aral,X) :-
    safe(X).
```

## Query 1

```prolog
?- safe(bonds).
```

## Output

```text
true.
```

## Query 2

```prolog
?- safe(gold).
```

## Output

```text
true.
```

## Query 3

```prolog
?- invests(aral,stock).
```

## Output

```text
true.
```

## Result

Thus, the Financial Investment Knowledge was successfully represented using FOL, converted into clause form, and implemented in Prolog.
