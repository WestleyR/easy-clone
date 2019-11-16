## Tab completion for git clone

Helper script to clone repos!

## Install

Install via brew:

_**NOTE:** you will need to add my tap first:_

```
$ brew tap WestleyR/core
```

After adding my tap, your can install like normal:

```
$ brew install easy-clone
```

<br>

Or, clone the repo:

```
git clone https://github.com/WestleyR/easy-clone
cd easy-clone/
./install.sh --prefix ~/

source ~/.bashrc
```

If you use `~/` as you prefix, this will leave a `~/bin` directory; if you
want it there, make sure you add it to your PATH. Otherwise (recomended) you
take the contens of the `~/bin` (witch will be `hubget`) and move it to your
prefured location, like: `/usr/local/bin`, `~/.local/bin`, etc...

<br>

## Usage


And now you can clone repo much easier. Heres a example:

```
hubget <TAB> <TAB>
```

And you should see some stuff like:

```
WestleyK/arduino-key-pad         WestleyK/drive-speed-test        WestleyK/pi-backlight            golang/dep
WestleyK/drive-mount             WestleyK/easy-clone              WestleyK/rpi-brightness          WestleyK/ssh-watcher
WestleyK/drive-mounting-script   WestleyK/install-script
```

If you don't, then try to close then reopen the terminal and it should work now.
If it still doesn't work, then please open an issue.


If your cloning a new repo (a repo you didnt clone before with hubget), the first
time it wont have tab completion, but the next time you clone it it will!

```
$ hubget WestleyR/wh<TAB><TAB>
# nothing
$ hubget WestleyR/whereis <ENTER>
Cloning repo...
```

And next time you clone that repo:

```
$ hubget WestleyR/wh<TAB>
$ hubget WestleyR/whereis
```

<br>

