gui = new Gui();
game_controller = new GameController();

gui.input_provider.InputProviderRegister(game_controller);
game_controller.game_state.GameEventSubjectAddObserver(gui);

game_controller.GameControllerInit();

token_text = new TokenText("I like writing sample text to test my font alignment system.\nThis bit is on its own line\n",FontVector7,c_yellow);
token_text.TokenTextAddString("and this bit is red.",c_red);
token_text.TokenTextAddString("This bit is blue.",c_blue);
token_text.TokenTextSetMaxSize(120,40);
token_text.TokenTextSetAlignment(fa_right,fa_bottom);

token_text2 = new TokenText("Happy: ",FontVector7,c_white);
token_text2.TokenTextAddSprite(SprIconTest,0,c_yellow);
token_text2.TokenTextAddString("\nUnhappy: ");
token_text2.TokenTextAddSprite(SprIconTest,1,c_red);
token_text2.TokenTextSetAlignment(fa_right,fa_middle);
token_text2.TokenTextSetLineSeparation(8);
token_text2.TokenTextSetMaxSize(80,40);