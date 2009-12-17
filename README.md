Skyline CMS Demo implementation
===============================

**Homepage**:  [http://www.skylinecms.nl](http://www.skylinecms.nl)   
**IRC**:       Join us on IRC in #skylinecms on irc.freenode.net!  
**Twitter**:   Follow [skylinecms](http://www.twitter.com/skylinecms) on twitter  
**Git**:       [http://github.com/digitpaint/skyline_demo_site](http://github.com/digitpaint/skyline_demo_site)   
**Author**:    DigitPaint  
**License**:   LGPL

Synopsis
--------

This is the demo implementation for [http://www.skylinecms.nl](Skyline) it's not only meant
to demonstrate most of Skyline's functionality but also as a reference for
all Skyline developers.

Before you get started
----------------------

The demo currently only has been tested with **Ruby 1.8.6**, **Bundler >= 0.7**, and **MySQL 5.x**. We're working
on alternative versions that work with Sqlite3.

Installation and usage
----------------------

**1. Bundler** We're using bundler in this implementation so:

    sudo gem install bundler

**2. Get the demo** Clone the git repository or download the zip from github.

    git clone git://github.com/DigitPaint/skyline_demo_site.git
  
**3. Bundle gems** Bundle all gems by running:

    cd skyline_demo_site
    gem bundle

**4. Set up database.yml** We've included an example file in `config/database.example.yml`
copy it and modify it to match your setup.
    
**5. Import the data** Create and import the database:

    rake db:create
    rake demo:setup
    
**6. Start the server** and enjoy Skyline!

    ./script/server
    
We've created two default users, one with admin permissions and one with regular
editor permissions. (See `db/fixtures/roles.db`)

**Admin**  
Login:      admin@skylinecms.nl  
Password:   admin

**Editor**  
Login:      editor@skylinecms.nl  
Password:   editor  

If you're running into problems, don't hesitate to contact us!

Copyright
---------

Skyline CMS &copy; 2009 by [DigitPaint](mailto:info@digitpaint.nl). Licensed under the LGPL
license. Please see the {file:COPYING} and {file:COPYING.LESSER} for more information.
