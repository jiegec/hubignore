hubignore
=================================================================
Download and manage git ignores from github/gitignore.

GitHub has a great collection of .gitignores in github/gitignore.
This tool is to help using these gitignores within your own .gitignore.

INSTALL
-------
    $ gem install hubignore

USE
---
Put this to your .gitignore:
```
## HubIgnore Begin: Ruby
## HubIgnore End.  
```
    $ hubignore
Then .gitignore will be:
```
## HubIgnore Begin: Ruby, C++
## Ruby Begins:
#{The content of https://raw.githubusercontent.com/github/gitignore/master/Ruby.gitignore Here}
## C++ Begins:
#{The content of https://raw.githubusercontent.com/github/gitignore/master/C++.gitignore Here}
## HubIgnore End.
```
