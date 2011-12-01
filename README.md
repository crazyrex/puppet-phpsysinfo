puppet-phpsysinfo
-----------------

This module is installing the PHP software [PhpSysInfo](http://phpsysinfo.sourceforge.net/ "phpsysinfo").
This is a /proc reader and display the information to a web page.
It allows you to get the state of your server very quickly.

Installation
------------

Login to your puppetmaster server
Clone the repository:

    git clone https://github.com/drivard/puppet-phpsysinfo.git

Move the cloned repository to the puppet module folder under the name of phpsysinfo
  
    mv puppet-phpsysinfo /etc/puppet/modules/phpsysinfo
  
Add the phpsysinfo module to your puppet node, for node definition look in the examples folder for the file phpsysinfo.
(Do not name your node file phpsysinfo it will mix the node and the module.)

Supported Operating Systems
---------------------------

* Ubuntu 10.04, 10.10, 11.04
* Debian 6.0 squeeze

## OpenVZ consideration
If you install Ubuntu template and think about customizing
the updatenotifier parameter to true, it will return and error
message. This error message is:

**missing file __"/var/lib/update-notifier/updates-available"__

This is due to the template being a minimal installatiion of Ubuntu.

To do
-----

Make this puppet profile working under Fedora, CentOS. (work in progress)
