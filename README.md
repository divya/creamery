67272 Creamery Project: Phase 5 
Divya Mohan
---

The functionality of this app is designed around the primary uses for each kind of employee. The managers have more options to look at kinds of shifts (past, today, upcoming) while admins can create things with greater ease. 

The way times are translated is weird - because of this the ability to view jobs on certain days seems wrong but it's not, it's just in terms of the time my machine thinks the shifts are which is different from the times that are being displayed for inexplicable reasons. 


___

You will need to run `bundle install` to get the needed testing gems.  

You can populate the development database with realistic data by first running `rake db:populate`.  (We've added `rake db:drop`, `rake db:migrate`, `rake db:test:prepare` to the populate script so anytime you run it, it will completely reset both your dev and test databases.) This will give you five stores with over 200 employees (some active, some inactive), each having one or more assignments.  Of those some have shifts (some upcoming only, some past and upcoming) and associated jobs.  All users in the system have the same password: "creamery".
