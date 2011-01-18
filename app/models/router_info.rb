
# Copyright 2009 RDR
#
# This file is part of RDR.
# 
# RDR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# RDR is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
# 
# Date: 2009-09-3 14:14:29 +5300 (Thus, 25 Sept 2009)



class RouterInfo < ActiveRecord::Base

  belongs_to :routerinfo
  validates_presence_of :router_url ,         :message=>"Please Fillup the details about router url",                                                                                      :on=>:create or:update
 
  validates_inclusion_of :router_controller,  :message => "only these controller are available. if you want another then create first!??!!",   :in => %w( dynamic_routs test1 test2 ),     :on=>:create or:update      
  
  validates_presence_of :router_action ,       :message=>"Please selecte appropriate router ",                                                                                             :on=>:create or:update
end
