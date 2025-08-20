// Is there a relationship between merchant_type and frauds?
MATCH (m:Merchant)
OPTIONAL MATCH (m)<-[:receives]-(t:Transaction)
WITH m, 
     SUM(CASE WHEN (t.is_fraud = 'True' OR toBoolean(t.is_fraud) = true) THEN 1 ELSE 0 END) AS frauds,
     COUNT(t) AS total
WHERE total > 0
RETURN m.nome AS merchant, frauds, total, toFloat(frauds)/toFloat(total) AS fraud_rate
ORDER BY fraud_rate DESC, frauds DESC
LIMIT 20;

// Countries with the highest number of frauds
MATCH (co:Country)<-[:from]-(t:Transaction)
WHERE t.is_fraud = 'True' OR toBoolean(t.is_fraud) = true
WITH co.nome AS country, COUNT(t) AS total_frauds
RETURN country, total_frauds
ORDER BY total_frauds DESC;

// Most fraudulent merchant per country
MATCH (co:Country)
CALL {
  WITH co
  MATCH (co)<-[:from]-(t:Transaction)-[:receives]->(m:Merchant)
  WHERE t.is_fraud = 'True' OR toBoolean(t.is_fraud) = true
  RETURN m, COUNT(t) AS fraud_count
  ORDER BY fraud_count DESC
  LIMIT 1
}
RETURN co, m, fraud_count
ORDER BY fraud_count DESC;

// View complete transaction
MATCH (c:Customer)-[:do]->(t:Transaction)-[:own]->(cur:Currency)
MATCH (t)-[:from]->(ct:Country)
MATCH (t)-[:receives]->(m:Merchant)-[:belong_to]->(mc:MerchantCategory)
MATCH (m)-[:have]->(ty:MerchantType) 
WHERE t.nome = 'TX_ff845053' 
RETURN t, c, cur, ct, m, mc, ty;
