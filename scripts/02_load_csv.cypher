// Loading merchants
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MERGE (:Merchant {nome: l.merchant, risco: l.high_risk_merchant});

// Loading transactions
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MERGE (:Transaction {nome: l.transaction_id});

// Loading customers
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MERGE (:Customer {nome: l.customer_id});