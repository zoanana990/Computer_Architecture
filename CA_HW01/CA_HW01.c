#include<stdio.h>
#include<stdlib.h>
int minCostClimbingStairs(int* cost, int costSize){
    if(costSize==0) return 0;
    if(costSize==1) return *cost;
    if(costSize==2) return *(cost+1)>*(cost)?*(cost):*(cost+1);
    int prev2 = *cost; 
    int prev1 = *(cost+1);
    for(int i=2;i<costSize;i++){
        int temp = (prev1>prev2?prev2:prev1) + *(cost+i);
        prev2 = prev1;
        prev1 = temp;
    }
    return (prev1>prev2?prev2:prev1);
}
int main(){
    int costSize=10;
    int cost[10]={1, 100, 1, 1, 1, 100, 1, 1, 100, 1};
    int ans=minCostClimbingStairs(cost, costSize);
    printf("Min Cost = %d\n", ans);
    return 0;
}