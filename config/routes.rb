
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



# You can have the root of your site routed with map.root
# Note: The default routes make all actions in every controller accessible via GET requests. You should
# consider removing the them or commenting them out if you're using named routes and resources.
ActionController::Routing::Routes.draw do |map|
  
  begin
      record_array = RouterInfo.find(:all)			# get records(route info) from Model
      if record_array.nil?							# if table is empty then
         raise Exception    						# raise exception
      else  
         for record in record_array				# get record and eval with map connect 
          eval "map.connect '#{record.router_url}', :controller => '#{record.router_controller}', :action => '#{record.router_action}'"
         end
      end
  rescue Exception
   	  redirect_to :controller => '/dynamic_routs', :action => 'list'
  end
  
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.root :controller => "dynamic_routs"
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
            
  
end

