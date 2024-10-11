select name from Customer
where Customer.referee_id is null or Customer.referee_id != 2;
