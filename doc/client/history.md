# state logging
lib/config creates indexeddb table log
 log: "++id,timestamp,state,params"
 

state changes write to log, unless the target state has  
`data:{"history":false}`