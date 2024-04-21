1. [DONE] Understand the RDS resource and which necessary resources we need
2. [DONE] Create a module with the standard structure
3. [DONE] Implement variable validation
4. [DONE] Implement networking validation
  4.1 [DONE] Receive subnet ids and security group ids via variables
  4.2 [DONE] For subnets:
    4.2.1 [DONE] Make sure that they are not in the default VPC
    4.2.2 [DONE] Make sure that they are private:
      4.2.2.1 [DONE] Check whether they are tagged with Access=Private
  4.3 [DONE] For security groups:
    4.3.1 [DONE] Make sure that there are no inbound rules for IP addresses
5. [DONE] Create the necessary resources and make sure the validation is working
6. [DONE] Create the RDS instance inside of the module
