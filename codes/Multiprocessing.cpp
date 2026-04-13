#include <thread>
#include <iostream>
#include <chrono>
using namespace std;

# define TASKS 10000

void func(){
this_thread::sleep_for(chrono::milliseconds(1000));
}
int main (){
thread t[TASKS];
for (int i=0;i<TASKS;i++){
t[i]=thread(func);
}
for (int i=0;i<TASKS;i++){
t[i].join();
}
}