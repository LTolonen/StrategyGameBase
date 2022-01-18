gui = new Gui();
game_controller = new GameController();

gui.input_provider.InputProviderRegister(game_controller);
game_controller.game_state.GameEventSubjectAddObserver(gui);

row_group = new GuiRowGroup(gui,0,400,20,200,400);
row_group.GuiRowGroupAddFixedRow(20);
row_group.GuiRowGroupAddFixedRow(40);
row_group.GuiRowGroupAddWeightedRow(1);
row_group.GuiRowGroupAddWeightedRow(2);
row_group.GuiRowGroupAddWeightedRow(1);
row_group.GuiRowGroupAddWeightedRow(5);

rectangle1 = new GuiTestRectangle(gui,0,0,0,10,10,c_red);
rectangle1.GuiElementSetParent(row_group.GuiRowGroupGetRow(3));
rectangle1.parent_element.padding_h = 4;
rectangle1.parent_element.padding_v = 4;
rectangle1.GuiElementSetFitToParent();

column_group = new GuiColumnGroup(gui,0,20,300,200,200);
column_group.GuiColumnGroupAddWeightedColumn(1);
column_group.GuiColumnGroupAddFixedColumn(50);
column_group.GuiColumnGroupAddWeightedColumn(1);

rectangle2 = new GuiTestRectangle(gui,0,0,0,10,10,c_green);
rectangle2.GuiElementSetParent(column_group.GuiColumnGroupGetColumn(1));
rectangle2.GuiElementSetFitToParent();

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