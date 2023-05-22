%Gathering Data:
Costs = [10,30,50,20,60,50,10,10,10,20,40,10,10]; 
%all the costs (variable and fixed) per service or product
C = sparse(diag([1,2,27,1,2,13,2,5,2,2,10,2,3])); %costumers per service
Profit = [1.8,1.57,1.58,1.6,1.77,1.64,1,1.5,1.8,1.66,1.43,1.6,1.66]; %wanted profit percentage per service
MP = (Costs.*Profit)'; %minimal price per service
PBI = [30,50,100,50,220,120,10,10,50,60,70,25,30]; %Price Before Increase
PAI = [50,70,120,50,270,140,10,20,50,60,70,25,30]; %Price After Increase

%Optimal solution:
cvx_begin
variable X(13)
    minimize X(13)
    subject to
    sum(C*X) <= 8524.33;
    for i = 1:1:length(X)
        if PBI(i) == PAI(i)
            MP(i) <= X(i) <= PAI(i)
        else
        PBI(i) <= X(i) <= PAI(i);
        MP(i) <= X(i)
        end
    end
cvx_end

%Displaying optimal solution:
xlswrite("MinimalPrice.xlsx",X,"D2:D14");
xlswrite("MinimalPrice.xlsx",ceil(X),"E2:E14");