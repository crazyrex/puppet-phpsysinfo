#
# This file is part of puppet-phpsysinfo ( https://github.com/drivard/puppet-phpsysinfo ).
#
# Copyright (C) 2011 Dominick Rivard <dominick.rivard@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This configuration will install PhpSysInfo into /usr/share/phpsysinfo
# and will create a virtualhost configuration file that will listen to port 8001.
# To access PhpSysInfo go to: http://your_server_hostname:8001/
#
node your_server_hostname {
  #
  # Custom Variables
  #
  
  #
  # Server configuration
  #
  class {
    'phpsysinfo':
                                                            #
                                                            # Server configuration
                                                            #
      port_number             => "8001",                    # The port number on which you will contact phpsysinfo
      admin_email_address     => "webmaster@localhost",     # The email address in the virtual host configuration file
      phpsysinfo_path         => "/usr/share/phpsysinfo/",  # The path where to extract phpsysinfo (Please do not forget the closing /)
                                                            #
                                                            # PhpSysInfo Theme preferences
                                                            #
      default_theme           => "phpsysinfo",              # possible values: "aqua, clean, cream, jstyle_blue, jstyle_green, nextgen, phpsysinfo, two"
      display_theme_picker    => "true",
      default_language        => "en",                      # PhpSysInfo Language preferences
      display_language_picker => "true",
                                                            #
                                                            # Plugins Settings
                                                            #
      psstatus                => "false",                   # PSStatus - show a graphical representation if a process is running or not
      psstatus_processes_list => "sshd,apache2",            # the process list you want to monitor
      ps                      => "false",                   # PS - show a process tree of all running processes
      updatenotifier          => "false",                   # UpdateNotifier - show update notifications (only for Ubuntu server)
      mdstatus                => "false",                   # MDStatus - show the raid status and whats currently going on
      smart                   => "false",                   # SMART - show S.M.A.R.T. information from drives that support it
      ipmi                    => "false";                   # ipmi - show IPMI status
  }

  # Modules
  include base, phpsysinfo
}