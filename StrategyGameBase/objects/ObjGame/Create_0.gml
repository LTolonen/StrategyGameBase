gui = new Gui();
game_controller = new GameController();

gui.input_provider.InputProviderRegister(game_controller);
game_controller.game_state.GameEventSubjectAddObserver(gui);

game_controller.GameControllerInit();

token_text = new TokenText("I like writing sample text to test my font alignment system.\nThis bit is on its own line\n",FontVector7,c_yellow);
token_text.TokenTextAddString("and this bit is red.",c_red);
token_text.TokenTextAddString("This bit is blue.",c_blue);
token_text.TokenTextSetMaxSize(120,);
token_text.TokenTextSetAlignment(fa_right,fa_bottom);