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
class phpsysinfo::config {
  $p_default_language		      = $phpsysinfo::default_language
  $p_default_theme			      = $phpsysinfo::default_theme
  $p_display_language_picker	= $phpsysinfo::display_language_picker
  $p_display_theme_picker		  = $phpsysinfo::display_theme_picker

  if $phpsysinfo::port_number != 80 {
    file {
      "/etc/apache2/sites-available/phpsysinfo":
        owner   => "root",
			  group   => "root",
			  mode    => "0644",		  
  			ensure  => file,
			  content => template("phpsysinfo/phpsysinfo.erb");
		}
		
		exec { 
      "a2ensite phpsysinfo":
        unless  => "test -f /etc/apache2/sites-enabled/phpsysinfo",
        require => [File["/etc/apache2/sites-available/phpsysinfo"],];
	  }
  }else{
    exec { 
      "a2ensite default":
        unless  => "test -f /etc/apache2/sites-enabled/000-default";
	  }
  }
  
  if $operatingsystem == "Ubuntu" {
    if $phpsysinfo::updatenotifier == 'true' {
      $p_updatenotifier = "UpdateNotifier"
    }else{
      $p_updatenotifier = ""
    }
  }
  
  if $phpsysinfo::mdstatus == 'true' {
    $p_mdstatus = "MDStatus"
  }else{
    $p_mdstatus = ""
  }
  
  if $phpsysinfo::smart == 'true' {
    $p_smart = "SMART"
  }else{
    $p_smart = ""
  }
  
  if $phpsysinfo::ipmi == 'true' {
    $p_ipmi = "ipmi"
  }else{
    $p_ipmi = ""
  }
  
  if $phpsysinfo::psstatus == 'true' {
    $p_psstatus = "PSStatus"
    file {
      "${phpsysinfo::phpsysinfo_path}plugins/PSStatus/PSStatus.config.php":
        owner   => "root",
			  group   => "root",
			  mode    => "0644",		  
  			ensure  => file,
			  content => template("phpsysinfo/PSStatus.config.php.erb");
		}
  }else{
    $p_psstatus = ""
  }
  
  if $phpsysinfo::ps == 'true' {
    $p_ps = "PS"
  }else{
    $p_ps = ""
  }
  
  if $p_updatenotifier == "" and  $p_mdstatus == "" and  $p_smart == "" and  $p_smart == "" and  $p_ipmi == "" and  $p_psstatus == "" and  $p_ps == "" {
    $psi_plugins = "false"
  }else{
    $psi_plugins = comma_seperated_list($p_updatenotifier, $p_mdstatus, $p_smart, $p_ipmi, $p_psstatus, $p_ps)
  }
  
  file {
    "${phpsysinfo::phpsysinfo_path}config.php":
      owner   => "root",
			group   => "root",
			mode    => "0644",
			ensure  => file,
			content => template("phpsysinfo/config.php.erb");
  }
  
  if $phpsysinfo::phpsysinfo_path == "/var/www/" {
    file {
      "/var/www/index.html":
        ensure  => absent;
    }
  }
}
