
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


# This file is used for creating/removing the defined table (structure) into/from database.
class CreateRouterInfos < ActiveRecord::Migration
  def self.up
    create_table :router_infos do |t|
        t.string :router_url
        t.string :router_controller
        t.string :router_action
        t.timestamps
     end
  end

  def self.down
    drop_table :router_infos
  end
end
