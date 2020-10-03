module RollOutcome
  include GameHelper
  
  def roll_holding_options
    # Roll prompt is written each time to avoid accumulated options when adding
    @main_ui.prompt = {
      type: "select",
      header: "Hold at least one value/set and confirm :",
      options: ["Confirm Holds", "Exit to menu"],
      values: ["confirm_holds", "exit_to_menu"],
      colors: [nil, nil]
    }
    prompt_values = @game.get_game_array("valid_dice_options_prompts")
    for i in (0..prompt_values.length-1).reverse_each do
      @main_ui.prompt[:options].unshift(prompt_values[i])
      @main_ui.prompt[:values].unshift("hold: " + i.to_s)
      @main_ui.prompt[:colors].unshift(nil)
    end
  end

  def roll_bust_outcome
    @instruction += INSTRUCTION_ROLL_OUTCOME1
    @main_ui.prompt = PROMPT_BUST
  end

  def roll_chain_outcome
    @instruction += INSTRUCTION_ROLL_OUTCOME2
    @main_ui.prompt = PROMPT_CHAIN
  end

  def roll_hold_outcome
    @instruction += INSTRUCTION_ROLL_OUTCOME3
    roll_holding_options
  end

  def check_win_condition
    player_score_total = @game.get_game_value("pot", 0) + @game.get_game_value("player_score", @game.active_player_index)
    if player_score_total >= 10000
      @instruction += INSTRUCTION_ROLL_OUTCOME4
      @main_ui.prompt = PROMPT_WIN
    end
  end
  
  def roll_prompt_result
    @instruction = INSTRUCTION_ROLL_OUTCOME
    free_dice_number = @game.get_game_value("free_dice_number", nil)
    case @game.get_game_value("valid_dice_options_dice_number", nil)
    when 0 then roll_bust_outcome
    when free_dice_number then roll_chain_outcome
    else roll_hold_outcome
    end
    check_win_condition
    @main_ui.instruction = @instruction
    active_round_refresh
  end

  def roll_free_dice
    @game.game_method("roll")
    @held_selection_count = 0
    roll_prompt_result
  end

  def chain_roll_dice
    @game.set_game_value("free_all_dice", nil, nil)
    roll_free_dice
  end

  def hold_value_selected
    index = @main_ui.prompt_selection.split[1].to_i
    @main_ui.prompt[:values][index] = "free: " + index.to_s
    @main_ui.prompt[:colors][index] = {background: :green}
    @game.set_game_value("hold_free_dice", "held", index)
    @held_selection_count += 1
    active_round_refresh
  end

  def free_value_selected
    index = @main_ui.prompt_selection.split[1].to_i
    @main_ui.prompt[:values][index] = "hold: " + index.to_s
    @main_ui.prompt[:colors][index] = nil
    @game.set_game_value("hold_free_dice", "free", index)
    @held_selection_count -= 1
    active_round_refresh
  end

  def confirm_holds
    # Check if there is at least one option that has been selected
    if @held_selection_count > 0
      @main_ui.instruction = INSTRUCTION_TURN_OPTIONS
      @main_ui.prompt = PROMPT_TURN_OPTIONS
    else
      @main_ui.instruction = INSTRUCTION_ROLL_OUTCOME + INSTRUCTION_ROLL_OUTCOME3 + INSTRUCTION_HOLD_ERROR
    end
  end

end