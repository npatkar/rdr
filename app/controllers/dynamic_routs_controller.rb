
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


# This is a controller class named "DynamicRoutsController" which extends the controller class "ApplicationController" and is accessible by "dynamic_routs".action_name
class DynamicRoutsController < ApplicationController
	protect_from_forgery :except => [:create_route] 


# This action reads data (or route) from database, table "mynewrdr.router_infos" 
# and stored in instance variable "@dynamic_routes", that is used in redirected view "index.html.erb".
  def list
       @dynamic_routes = RouterInfo.find(:all)		
       respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @dynamic_routes }
       end
  end

 
# Here, route from database is found upon id and the specific route is remove from database. 
# Then control is redirected to action "list"  
  def deleteroute
      @dyn_route = RouterInfo.find(params[:id])
      @dyn_route.destroy  
      redirect_to :action => 'list'
  end 

  
# This action allows you to edit existing route from database 
  def editroute  
     @dirname=(File.dirname("C:\\ruby\\rdr2_3_2\\app\\controllers\\.")).to_s
     @arr=Dir.entries(@dirname) 
     $array=Array.new        
  	 for i in 0..@arr.length-1
  	 if @arr[i]=="." or @arr[i]==".." 	          
  	    @arr.delete("@arr[i]")
  	 else    
  	   $array[i-2]=@arr[i].gsub(".rb","")		    
  	 end        
  	end 
  	for i in 0..$array.length-1
  	$array[i]=$array[i].gsub("_controller","")
  	end  
    $dyn_route = RouterInfo.find(params[:id])
    @dyn = RouterInfo.find(params[:id]) 
    logger.info("edit ROUTE Value : " )  
  end

  
# Here route info from view (or editroute.html.erb)is used to update the existing route into db.
  def updateroute 
        logger.info("ROUTE Value : ")
        @routerinfo = RouterInfo.find(params[:routerinfo][:id])
       if @routerinfo.update_attributes(params[:routerinfo])
          map_routes()
       
       redirect_to :action => 'list', :id => @routerinfo
       else
        render :action => 'editroute'
        end
  end


# For dynamic routing "Update map:resource", all the routes from database is obtained and real mapping is done here.  
  def map_routes()
    ActionController::Routing::Routes.draw do |map|
      begin
      record_array = RouterInfo.find(:all)			# get records(route info) from Model
      if record_array.nil?							# if table is empty then
      raise Exception    						    # raise exception
      else  
      for record in record_array				    # get record and eval with map connect 
      eval "map.connect '#{record.router_url}', :controller => '#{record.router_controller}', :action => '#{record.router_action}'"
      end
      end
      rescue Exception
      puts("Exception occure due to empty record")	
      end
     end
  end
                   
   
  
# Here, name of the controllers used in the application are found and are added in the drop down box,
# which is used while creating the route.
  def controllers_list
      @dirname=(File.dirname("C:\\ruby\\rdr2_3_2\\app\\controllers\\.")).to_s
      @arr=Dir.entries(@dirname) 
      $array=Array.new        
      for i in 0..@arr.length-1
       if @arr[i]=="." or @arr[i]==".." 	          
       @arr.delete("@arr[i]")
       else    
       $array[i-2]=@arr[i].gsub(".rb","")		    
       end        
      end 
       for i in 0..$array.length-1
       $array[i]=$array[i].gsub("_controller","")
       end
       redirect_to(:controller=>"dynamic_routs", :action=>"create_route") 
  end
 
 
     
# This action is called from controllers_list action for creating new route and is redirected to the view ( create_route.html.erb ).
# Also this action is called from the view on form submit, if the route is created successfully then it is further redirected to list action else
# it is redirected to the same view page i.e. create_route.html.erb .
  def create_route
      return unless request.post?
      @routerinfo = RouterInfo.new(params[:routerinfo])
      respond_to do |format|
        if @routerinfo.save
        map_routes()
        flash[:notice] = 'Commute was successfully created.'
        format.html { redirect_to :action=>'list'}
        format.xml  { render :xml => @routerinfo, :status => :created, :location => @routerinfo}
       else
        format.html { render :action => "create_route" }
        format.xml  { render :xml => @routerinfo.errors, :status => :unprocessable_entity }
       end
      end
  end


  
# Here, name of the actions used in a particular controller, which is selected from the drop down box while creating or editing a route
# are found and are listed in the "router_action" drop down box, used in the views.  
  def actions_list
    @cont=params[:cont]
    if @cont=='application'
    $filename="C:\\ruby\\rdr2_3_2\\app\\controllers\\"+@cont.to_s+".rb"       
    else
    $filename="C:\\ruby\\rdr2_3_2\\app\\controllers\\"+@cont.to_s+"_controller.rb"
    end          
    $arr2=Array.new
    @str=open($filename,"r")  {|f| f.read}	      
    @arr1=@str.split('def')
    if @arr1.length==0
    render_text "<option>#{"No Action"}</option>" 
    elseif @cont=='dynamic_routs'
        for i in 1..@arr1.length-2           
         s = StringScanner.new(@arr1[i])
         s.scan(/\s*/) 
         $arr2[i-1]=s.scan(/\w+/)
        end
    else
      for i in 1..@arr1.length-1           
      s = StringScanner.new(@arr1[i])
      s.scan(/\s*/) 
      $arr2[i-1]=s.scan(/\w+/)
      end
   end          
   render :inline => "<%=options_for_select ($arr2)%>" 
   end 
   
end
                
              

