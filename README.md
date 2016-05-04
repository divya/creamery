67272 Creamery Project: Phase 5 
Divya Mohan
---






___

You will need to run `bundle install` to get the needed testing gems.  

You can populate the development database with realistic data by first running `rake db:populate`.  (We've added `rake db:drop`, `rake db:migrate`, `rake db:test:prepare` to the populate script so anytime you run it, it will completely reset both your dev and test databases.) This will give you five stores with over 200 employees (some active, some inactive), each having one or more assignments.  Of those some have shifts (some upcoming only, some past and upcoming) and associated jobs.  All users in the system have the same password: "creamery".
