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
class phpsysinfo (
  $port_number, 
  $admin_email_address, 
  $phpsysinfo_path, 
  $default_theme, 
  $display_theme_picker, 
  $default_language, 
  $display_language_picker,
  $psstatus, 
  $psstatus_processes_list, 
  $ps, 
  $updatenotifier, 
  $mdstatus, 
  $smart, 
  $ipmi
)
{
  # List of packages that will be install on each node
  $package_list = [
    "build-essential",
    "apache2",
    "php5",
    "php5-curl",
    "php5-mysql",
    "libapache2-mod-php5",
  ]

  include phpsysinfo::install, phpsysinfo::config, phpsysinfo::service
  
  # Module Dependencies
  Class['phpsysinfo::install'] -> Class['phpsysinfo::config'] -> Class['phpsysinfo::service']
  Class['phpsysinfo::config'] ~> Class['phpsysinfo::service']
}
