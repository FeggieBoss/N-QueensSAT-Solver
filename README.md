# Решение задачи о расстановке n королев на поле n на n при помощи SAT-солвера 
[![Haskell CI](https://github.com/FeggieBoss/N-QueensSAT-Solver/actions/workflows/haskell.yml/badge.svg)](https://github.com/FeggieBoss/N-QueensSAT-Solver/actions/workflows/haskell.yml)
### Запуск:  
``` 
$> stack build  
$> stack run -- "put n here"
```
### Пример:
```
$> stack build  
$> stack run -- 5
. . . . Q 
. . Q . . 
Q . . . . 
. . . Q . 
. Q . . . 
```

### Тестирование:  
``` 
$> stack test
```
### Пример:
```
$> stack test
Tests:
  Satisfiable Tests
    Trivial
      n = 0:  OK
      n = 1:  OK
    Main
      n = 4:  OK
      n = 5:  OK
      n = 6:  OK
      n = 7:  OK
      n = 8:  OK
      n = 9:  OK
      n = 10: OK
      n = 11: OK
      n = 12: OK (0.01s)
      n = 13: OK (0.01s)
      n = 14: OK (0.06s)
      n = 15: OK (0.01s)
      n = 16: OK (0.06s)
      n = 17: OK (0.07s)
      n = 18: OK (0.06s)
      n = 19: OK (0.08s)
      n = 20: OK (0.07s)
  Unsatisfiable Tests
    n = 2:    OK
    n = 3:    OK

All 21 tests passed (0.14s)
```  
