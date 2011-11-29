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
class phpsysinfo::install {
  # This will install all the necessary packages for phpsysinfo
  package { 
    $phpsysinfo::package_list:
      ensure => present;  
  }
  
  file { 
    "/tmp/phpsysinfo-latest.tar.gz":
      owner   => "root",
			group   => "root",
			mode    => "0644",
			ensure  => file,
      source  => "puppet:///modules/phpsysinfo/phpsysinfo-latest.tar.gz";
      
    "${phpsysinfo::phpsysinfo_path}":
      owner   => "root",
			group   => "root",
			mode    => "0755",
			ensure  => directory;
  }
  
  # Untar the phpsysinfo tarball into /usr/share/phpsysinfo
  exec {
    "untar_phpsysinfo":
      command => "/bin/tar zxvf /tmp/phpsysinfo-latest.tar.gz",
      cwd     => "/tmp/",
      creates => "/tmp/phpsysinfo/index.php",
      unless  => "test -f ${phpsysinfo::phpsysinfo_path}index.php",
      require => [File["/tmp/phpsysinfo-latest.tar.gz"], File["${phpsysinfo::phpsysinfo_path}"], ];
      
    "move_untared_files":
      command => "/bin/mv /tmp/phpsysinfo/* ${phpsysinfo::phpsysinfo_path}",
      cwd     => "/tmp/",
      creates => "${phpsysinfo::phpsysinfo_path}index.php",
      unless  => "test -f ${phpsysinfo::phpsysinfo_path}index.php",
      require => [Exec["untar_phpsysinfo"], ];
  }
  
  if $ipmi == "true" {
    package {
      "ipmitool":
        ensure => present;
    }
  } 
}
