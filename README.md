small plugin that allows you to align selected columns using a symbol
for example it can turn this:
```
make_indexed = function(items) -> indexed_items, width,
make_displayer = function(widths) -> displayer
make_display = function(displayer) -> function(e)
make_ordinal = function(e) -> string
```
into this:
```
make_indexed   = function(items)     -> indexed_items, width,
make_displayer = function(widths)    -> displayer
make_display   = function(displayer) -> function(e)
make_ordinal   = function(e)         -> string
```
just aling using '=' and then using '->'
