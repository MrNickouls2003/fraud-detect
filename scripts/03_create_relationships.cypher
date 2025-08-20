// Merchant -> MerchantType
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (m:Merchant {nome: l.merchant})
MATCH (t:MerchantType {nome: l.merchant_type})
MERGE (m)-[:have]->(t);

// Merchant -> MerchantCategory
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (m:Merchant {nome: l.merchant})
MATCH (c:MerchantCategory {nome: l.merchant_category})
MERGE (m)-[:belong_to]->(c);

// Transaction -> Merchant
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (m:Merchant {nome: l.merchant})
MATCH (t:Transaction {nome: l.transaction_id})
MERGE (t)-[:receives]->(m);

// Transaction -> Currency
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (cur:Currency {nome: l.currency})
MATCH (t:Transaction {nome: l.transaction_id})
MERGE (t)-[:own]->(cur);

// Transaction -> Country
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (co:Country {nome: l.country})
MATCH (t:Transaction {nome: l.transaction_id})
MERGE (t)-[:from]->(co);

// Customer -> Transaction
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (c:Customer {nome: l.customer_id})
MATCH (t:Transaction {nome: l.transaction_id})
MERGE (c)-[:do]->(t);
