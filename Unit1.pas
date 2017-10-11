       unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, StrUtils, ShellApi,
  ComCtrls, CommCtrl;
type
  TForm1 = class(TForm)
    MainPanel: TPanel;
    keypanel: TPanel;
    IntroPanel: TPanel;
    WelcomeLabel: TLabel;
    GuessEdit: TEdit;
    Memo1: TMemo;
    WordCount: TLabel;
    AnswerEdit: TEdit;
    NewWord: TButton;
    LastClickLetter: TLabel;
    LetterCount: TLabel;
    WorkMemo: TMemo;
    Memo2: TMemo;
    AnswerBox: TMemo;
    WinPanel: TPanel;
    WinText: TLabel;
    RestartButton: TButton;
    Quit: TButton;
    ScoreLabel: TLabel;
    ChancesLabel: TLabel;
    RetryPanel: TPanel;
    RetryLabel: TLabel;
    RetryChances: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Dictionary: TButton;
    RetryChancesEdit: TEdit;
    WordFile: TRadioGroup;
    ResetStatsCheck: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Step2: TPanel;
    Label1: TLabel;
    FiveChanceIntro: TButton;
    TenChanceIntro: TButton;
    Panel1: TPanel;
    ChancesEdit: TLabeledEdit;
    Intro_Play: TButton;
    Label4: TLabel;
    ScoreBar: TProgressBar;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure keyboard;
    procedure Clickk(Sender:TObject);
    procedure Intro_PlayClick(Sender: TObject);
    procedure NewWordClick(Sender: TObject);
    procedure UpdateGuess;
    procedure QuitClick(Sender: TObject);
    procedure RestartButtonClick(Sender: TObject);
    procedure GuessEditChange(Sender: TObject);
    procedure FiveChanceIntroClick(Sender: TObject);
    procedure TenChanceIntroClick(Sender: TObject);
    procedure showwinpanel;
    procedure RetryPanelEnter(Sender: TObject);
    procedure RetryChancesClick(Sender: TObject);
    procedure DictionaryClick(Sender: TObject);
    procedure RetryChancesEditKeyPress(Sender: TObject; var Key: Char);
    procedure ChancesEditKeyPress(Sender: TObject; var Key: Char);
    procedure ChancesEditClick(Sender: TObject);
    procedure WordFileClick(Sender: TObject);
    procedure ChancesEditChange(Sender: TObject);
    procedure resetscore;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  charkey:Array[0..26] of TPanel;
  keyexist:string;
  correct,wrong,clicks,currentclicks,chances,score,round:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);   //Actions on form create
var
searchResult : TSearchRec;
begin
IntroPanel.Top:=0;
IntroPanel.Left:=0;
resetscore;
currentclicks:=0;
chances:=0;//reset chances to 0
ScoreBar.Position:=0;
IntroPanel.BringToFront;
IntroPanel.Caption:='';
WinPanel.Caption:='';
RetryPanel.Caption:='';
MainPanel.Caption:='';
keypanel.Caption:='';
RetryChancesEdit.Text:='';
Intro_Play.Caption:='Play'; //Setting Caption
Form1.ClientHeight:=MainPanel.Height;
Form1.ClientWidth:=MainPanel.Width;
SendMessage(ScoreBar.Handle, PBM_SETBARCOLOR, 0, clBlue);//start with blue scorebar
WordFile.Items.Clear;//clearWordFile
//WordFile.Items.Add('Hi') ;
if FindFirst('*.txt', faAnyFile, searchResult) = 0 then //Look for any .txt file for words
  begin
    repeat
    WordFile.Items.Add(searchResult.Name);
    until FindNext(searchResult) <> 0;
  end;
WelcomeLabel.Caption:='Welcome, choose the type of word that you would like to guess'+#13#10+'and how many chances you would like to have to get started';
end;

// --------------------------------Introduction Area----------------------------
procedure TForm1.FiveChanceIntroClick(Sender: TObject);
begin
  chances:=5;
  if ResetStatsCheck.Checked=True then  resetscore;  //reset score
  Intro_Play.Enabled:=True; Intro_Play.Click; //Enable Play button before clicking Intro_Play
end;

procedure TForm1.TenChanceIntroClick(Sender: TObject);
begin
  chances:=10;
  if ResetStatsCheck.Checked=True then resetscore;  //reset stats checked
  Intro_Play.Enabled:=True; Intro_Play.Click; //Enable Play button before proceding
end;

procedure TForm1.Intro_PlayClick(Sender: TObject); //Play Button
begin
if chances=0 then Showmessage('You need to fill in how many chances you want and not 0')  //while Chances edit not blank and radio choose text file selected
  else
  begin
  IntroPanel.Hide; //Hide Introduction Panel
  WinPanel.Hide;
  MainPanel.Show;
  Memo1.Lines.LoadFromFile(WordFile.Items[WordFile.ItemIndex]);  //Loads words from Words.txt
  round:=0;
  clicks:=0;
  NewWord.Click;
  ScoreLabel.Caption:='';
  ChancesLabel.Caption:=IntToStr(chances)+' chance(s) left';
  end;
end;

//------------------------------------Main Area--------------------------------
procedure TForm1.NewWordClick(Sender: TObject);  //Get a new word
var
i,l:integer; //i=generic l=length
begin
inc(round);
Randomize;   //Initialize random
i:=Random(Memo1.Lines.Count); //  Generate random number\
WordCount.Caption:='Selected from line '+IntToStr(i+1);    //Show the generated Number
AnswerEdit.Text:=Memo1.Lines[i];  //Set answeredit to the text from memo1 line *i*
l:=Length(AnswerEdit.Text);
LetterCount.Caption:='You''re now playing '+WordFile.Items[WordFile.ItemIndex]+', to change quit the game and restart'+#13#10+'There are '+IntToStr(l)+ ' letters(including space)';
AnswerBox.Text:='';
WorkMemo.Text:=AnswerEdit.Text;
i:=1;
CurrentClicks:=0;
while i<l do begin   //put the word into different lines for easier sorting... in my oppinion
  AnswerBox.Lines.Add(AnsiLeftStr(WorkMemo.Text,1));
  WorkMemo.Text:=AnsiRightStr(WorkMemo.Text,l-i); //Get the left most letter
  inc(i);
end;
AnswerBox.Lines.Add(WorkMemo.Text);  //Patch above code since the last letter did not come through
WorkMemo.Text:='';
keyboard; //reset keyboard
Memo2.Text:='';
while Memo2.Lines.Count<AnswerBox.Lines.Count do
 begin                         //Allowing space to be in the words.
 if AnswerBox.Lines[Memo2.Lines.Count]=' ' then Memo2.Lines.Add(' ')//memo 2 is multiple line of dashes where I keep the track of where to place "_" into the GuessEdit
  else
  if AnswerBox.Lines[Memo2.Lines.Count]='-' then Memo2.Lines.Add('-') //If there's a dash then show dash instead
    else Memo2.Lines.Add('?');
 end;
UpdateGuess;
Form1.Caption:='Guess A Word - Session '+IntToStr(round);
end;

procedure TForm1.keyboard;    //Create Keyboard
var
i,c:integer; //i=generic c=character code
begin
  i:=1; //starts working on first letter
  c:=97; //starts at letter "a" to 26th key "z"   char code source: http://www.delphibasics.co.uk/Article.asp?Name=Text
  if keyexist='yes' then //If exist, don't recreate
  while c<123 {until "z" is reached} do
    begin
    charkey[i].Show;
    inc(i);  //
    inc(c);  //next character
    end
  else
  while c<123 {until "z" is reached} do
    begin
    charkey[i]:=TPanel.Create(Self);
    charkey[i].Tag:=i;
    charkey[i].Font.Name:='Myraid Pro';
    charkey[i].Font.Style:=[];
    charkey[i].Parent:=keypanel; //parent as keypanel
    charkey[i].Height:=40;
    charkey[i].Width:=charkey[i].Height; //same height as width
    if charkey[i].Tag<(13.5) then
      begin
      charkey[i].Top:=2;
      charkey[i].Left:=2{margin}+(charkey[i].Height*(i-1){spacing});
      end
      else
        begin
        charkey[i].Top:=2+charkey[i].Height;
        charkey[i].Left:=2{margin}+(charkey[i].Height*((i-1)-(13)){spacing});
        end;
    charkey[i].Caption:=Chr(c);
    charkey[i].OnClick:=Clickk;
    inc(i);
    inc(c);
    end;
  keypanel.Height:=charkey[1].Height*2+4;
  keypanel.Width:=charkey[1].Width*13+2;
  keyexist:='yes';
end;

procedure TForm1.Clickk;  //Keyboard Button Click
var
i,g,prevcorrect:integer; //i=tag g=generic
capital,small:string;
begin
i:=TShape(Sender).Tag; //tag of object clicked
small:=Chr(i+96); //set small alphabet
capital:=Chr(i+64);   //set capital alphabet
LastClickLetter.Caption:='Last clicked letter = '+Chr(i+64);
charkey[i].Hide;
g:=0;
prevcorrect:=correct;
while g<Length(AnswerEdit.Text) do
begin
  inc(g);
  if AnswerBox.Lines[g-1] = Chr(i+96) then  //small alphabets
    begin
    Memo2.Lines[g-1]:=Chr(i+96);
    inc(correct);
    end;
  if AnswerBox.Lines[g-1] = Chr(i+64) then  //check capital alphabets
    begin
    Memo2.Lines[g-1]:=Chr(i+64);
    inc(correct);
    end;
  end;
score:=correct-wrong;//update score
UpdateGuess;
inc(clicks);
inc(CurrentClicks);
if prevcorrect=correct then
  begin
   inc(wrong); //if correct remains the same after keypress then wrong letter has been pressed. add value to wrong
   chances:=chances-1;
   ScoreBar.Position:=ScoreBar.Position-1;
   SendMessage(ScoreBar.Handle, PBM_SETBARCOLOR, 0, clRed)
  end
  else
  begin
    ScoreBar.Position:=ScoreBar.Position+1;
    SendMessage(ScoreBar.Handle, PBM_SETBARCOLOR, 0, clBlue);
  end;
ChancesLabel.Caption:='You have '+IntToStr(chances)+' chances left';
if chances<1 then  //LOST LOST LOST LOST
  begin
  RetryPanel.Show;
  WinText.Caption:='Sorry but you have lost.'+#13#10+'The word was '+AnswerEdit.Text+'.'+#13#10+'You have a score of '+IntToStr(score);
  showwinpanel;
  end;
ScoreLabel.Caption:='You have a score of '+IntToStr(score);
end;

procedure TForm1.UpdateGuess;//Update GuessEdit
var i:integer; // generic
begin
i:=0;//reset i to 1
GuessEdit.Text:='';//blank out GuessEdit
while i < Length(AnswerEdit.Text) do    //Copy lines of Memo2 into GuessEdit
  begin
  GuessEdit.Text:=GuessEdit.Text+Memo2.Lines[i];
  inc(i);
  end;
end;

procedure TForm1.GuessEditChange(Sender: TObject);
begin
if GuessEdit.Text=AnswerEdit.Text then    //WINNING
  begin
  RetryPanel.Hide;
  WinText.Caption:='Hooray you WON!!'+#13#10+'The word was '+AnswerEdit.Text+'.'+#13#10+'You have a score of '+IntToStr(score);
  showwinpanel;   //Show Win Panel
  end;
end;

//-----------------------------Winning/Losing Area----------------------------
procedure TForm1.showwinpanel;
begin
WinPanel.Show;
WinPanel.BringToFront;
WinPanel.Left:=129;
WinPanel.Top:=112;
IntroPanel.Hide;
MainPanel.Hide;
end;

procedure TForm1.RetryPanelEnter(Sender: TObject);
begin
RetryPanel.Caption:='';  //Remove RetryPanel caption
end;

procedure TForm1.RestartButtonClick(Sender: TObject);
begin
WinPanel.Hide;
NewWord.Click;
MainPanel.Show;
end;

procedure TForm1.RetryChancesClick(Sender: TObject); //Retry Click
begin
if RetryChancesEdit.Text='' then Showmessage('You need to fill in how many chances you want and not 0')  //while Chances edit not blank and radio choose text file selected
  else
  begin
  chances:=StrToInt(RetryChancesEdit.Text);
  if ResetStatsCheck.Checked=True then resetscore;
  Intro_Play.Click
  end;
end;

procedure TForm1.DictionaryClick(Sender: TObject); //Dictionary Button
var
URL, WordURL:string;
begin
  WordURL:=AnswerEdit.Text;
  WordURL:=StringReplace(WordURL,' ','%20',[rfReplaceAll,rfIgnoreCase]);
  URL :='http://dictionary.reference.com/browse/'+WordURL;
  ShellExecute(0,'open',PChar(URL),nil,nil,SW_SHOWNORMAL);
end;


procedure TForm1.RetryChancesEditKeyPress(Sender: TObject; var Key: Char);  // Discard unwanted keys
begin
  // #8 is Backspace
  if not (Key in [#8, '0'..'9']) then begin  //If keys are not numbers or backspace
    ShowMessage('Invalid key');
    Key := #0; //returns Null to the EditBox
  end;
end;

procedure TForm1.ChancesEditKeyPress(Sender: TObject; var Key: Char);
begin
  // #8 is Backspace
  if not (Key in [#8, '0'..'9']) then begin
    ShowMessage('Numbers only please');// Discard the key
    Key := #0; //Null key resulting in no unwanted texts
  end;
end;

procedure TForm1.resetscore; //reset score
begin
 correct:=0; wrong:=0;
end;

procedure TForm1.ChancesEditClick(Sender: TObject);
begin
ShowMessage('Click');
end;

procedure TForm1.WordFileClick(Sender: TObject); //Show step 2 after the type of word is selected
begin
Step2.Visible:=True;
end;

procedure TForm1.ChancesEditChange(Sender: TObject); //Enable "Play Button" after Custom Chance is entered
begin
if Not (ChancesEdit.Text='') then
begin
chances:=StrToInt(ChancesEdit.Text);
Intro_Play.Enabled:=True;
end
else Intro_Play.Enabled:=False;
end;

procedure TForm1.QuitClick(Sender: TObject);   //Close Program
begin
Close;
end;

end.
