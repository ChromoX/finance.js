## node-finance

**Description:** A financial framework for the manipulation of equities, derivatives securities, foreign exchange currencies, and debt instruments. Built in Node.js, but aims to work on both the browser-side as a standalone library and/or on the server-side on top of Node. Provides core functionality and a very modular plugin architecture such that higher-level programs can easily be written on top of the library as an abstraction layer.


**Goal:** To provide a toolkit of financial functionality that allows developers to rapidly create higher-level programs on top of it (strategies, alerts, simulations, etc..)


Plan to include support for the following:

* Stocks
* Bonds (corporate, municipal)
* Options
* Forex
* Futures


### Install
	git clone git@github.com:ChromoX/node-finance.git
	cd node-finance
	npm install -d
	cake build


### License
**Copyright (C) 2011 Jeffrey Portman & Dan Simmons**

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
