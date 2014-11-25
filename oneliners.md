# A list of useful one liners

1. Copy or rename many files

```
$ find . -type f -wholename \*.fas | sed 's/\(.*\)\.fas/cp "\1.fas" "\1"/' | sh
```
