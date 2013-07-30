module MatchesHelper

	def user_permission?
		true
		#be required: be owner of any team (local or visitor) 
	    #             or be owner of tourmentent
	    #             or be owner of sportCenter   
	    # user_signed_in? and (current_user == @match.local.owner or
	    # 					 current_user == @match.visitor.owner )
	end

  def title_table_goal (action)
    if action == 'edit'  
      t("matches.edit.accion")
    else
      t("matches.show.description")    
    end	
  end
  
  def column_table_goal (action, goal, match)
    if action == 'edit'  
      link_to t("matches.edit.delete_goal"), match_goal_path(@match,goal), method: 'delete'
    else
      goal.description
    end	
  end
  def button_add_goals (action, match, team)
    if action == 'edit'
      link_to t("matches.edit.add_goal"), new_match_goal_path(@match,team), method: 'get'
    end    
  end
  
end