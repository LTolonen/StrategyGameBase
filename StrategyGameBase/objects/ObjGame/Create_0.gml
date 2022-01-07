gui = new Gui();
game_controller = new GameController();

gui.input_provider.InputProviderRegister(game_controller);
game_controller.game_state.GameEventSubjectAddObserver(gui);

game_controller.GameControllerInit();