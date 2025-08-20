// Attributes Merchant
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (m:Merchant {nome: l.merchant})
SET m.high_risk_merchant = l.high_risk_merchant;

// Attributes Customer
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (c:Customer {nome: l.customer_id})
SET c.velocity_last_hour = l.velocity_last_hour;

// Attributes Transaction
LOAD CSV WITH HEADERS FROM 'file:///fraud.csv' AS l
MATCH (t:Transaction {nome: l.transaction_id})
SET t.channel = l.channel,
    t.distance_from_home = l.distance_from_home,
    t.device_fingerprint = l.device_fingerprint,
    t.ip_address = l.ip_address,
    t.card_type = l.card_type,
    t.is_fraud = l.is_fraud,
    t.timestamp = l.timestamp,
    t.amount = l.amount,
    t.transaction_hour = l.transaction_hour,
    t.weekend_transaction = l.weekend_transaction,
    t.card_number = l.card_number;
