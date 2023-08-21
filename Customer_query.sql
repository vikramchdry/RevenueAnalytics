select sc.customer_id,
CONCAT(sc.first_name,'',sc.last_name) as 'CustomerName',
sc.city,sc.state
from Sales.customers as sc