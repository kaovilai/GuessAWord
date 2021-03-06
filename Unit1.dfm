object Form1: TForm1
  Left = 468
  Top = 145
  HorzScrollBar.Visible = False
  AutoScroll = False
  Caption = 'Guess A Word'
  ClientHeight = 636
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object WordCount: TLabel
    Left = 216
    Top = 552
    Width = 54
    Height = 13
    Caption = 'WordCount'
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 409
    Caption = 'MainPanel'
    TabOrder = 0
    object LastClickLetter: TLabel
      Left = 0
      Top = 500
      Width = 70
      Height = 13
      Caption = 'LastClickLetter'
    end
    object LetterCount: TLabel
      Left = 16
      Top = 8
      Width = 55
      Height = 13
      Caption = 'LetterCount'
    end
    object ScoreLabel: TLabel
      Left = 496
      Top = 104
      Width = 54
      Height = 13
      Caption = 'ScoreLabel'
    end
    object ChancesLabel: TLabel
      Left = 600
      Top = 64
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'ChancesLabel'
    end
    object Label5: TLabel
      Left = 160
      Top = 192
      Width = 415
      Height = 13
      Caption = 
        'Lots of wrong characters<---------------------------------------' +
        '---------------->Lots of correct characters'
    end
    object keypanel: TPanel
      Left = 96
      Top = 216
      Width = 529
      Height = 97
      Caption = 'keypanel'
      TabOrder = 0
    end
    object GuessEdit: TEdit
      Left = 16
      Top = 120
      Width = 657
      Height = 46
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'GuessEdit__'
      OnChange = GuessEditChange
    end
    object NewWord: TButton
      Left = 600
      Top = 16
      Width = 75
      Height = 25
      Caption = 'NewWord'
      TabOrder = 2
      OnClick = NewWordClick
    end
    object ScoreBar: TProgressBar
      Left = 160
      Top = 176
      Width = 417
      Height = 17
      Min = -100
      Position = 100
      Smooth = True
      TabOrder = 3
    end
  end
  object IntroPanel: TPanel
    Left = -15
    Top = 384
    Width = 705
    Height = 409
    Caption = 'IntroPanel'
    TabOrder = 1
    object WelcomeLabel: TLabel
      Left = 8
      Top = 40
      Width = 869
      Height = 13
      Caption = 
        'Welcome, to get started; choose the type of word that you would ' +
        'like to guess and how many chances you would like to have by pre' +
        'ssing one of the buttons below or choose a custom number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Myriad Pro'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 0
      Width = 210
      Height = 38
      Caption = 'Guess A Word'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = 38
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object WordFile: TRadioGroup
      Left = 16
      Top = 72
      Width = 449
      Height = 137
      Caption = 
        'Step 1: Choose the type of words you want to guess in this game ' +
        'session.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Myriad Pro'
      Font.Style = []
      Items.Strings = (
        'HelloWorld')
      ParentFont = False
      TabOrder = 0
      OnClick = WordFileClick
    end
    object Step2: TPanel
      Left = 16
      Top = 208
      Width = 449
      Height = 137
      BevelOuter = bvNone
      Caption = 'Step2'
      TabOrder = 1
      Visible = False
      object Label1: TLabel
        Left = 0
        Top = 4
        Width = 424
        Height = 13
        Caption = 
          'Step 2: Choose the pre-made chances or choose a custom amount of' +
          ' chance then press "Play"'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Myriad Pro'
        Font.Style = []
        ParentFont = False
      end
      object FiveChanceIntro: TButton
        Left = 16
        Top = 56
        Width = 75
        Height = 25
        Caption = '5 Chances'
        TabOrder = 0
        OnClick = FiveChanceIntroClick
      end
      object TenChanceIntro: TButton
        Left = 96
        Top = 56
        Width = 75
        Height = 25
        Caption = '10 Chances'
        TabOrder = 1
        OnClick = TenChanceIntroClick
      end
      object Panel1: TPanel
        Left = 192
        Top = 24
        Width = 3
        Height = 97
        Caption = 'Panel1'
        Color = clBackground
        TabOrder = 2
      end
      object ChancesEdit: TLabeledEdit
        Left = 208
        Top = 60
        Width = 121
        Height = 21
        EditLabel.Width = 74
        EditLabel.Height = 13
        EditLabel.HelpType = htKeyword
        EditLabel.Caption = 'Custom Amount'
        MaxLength = 9
        TabOrder = 3
        OnChange = ChancesEditChange
        OnKeyPress = ChancesEditKeyPress
      end
      object Intro_Play: TButton
        Left = 336
        Top = 56
        Width = 75
        Height = 25
        Caption = 'Intro_Play'
        Default = True
        Enabled = False
        TabOrder = 4
        OnClick = Intro_PlayClick
      end
    end
  end
  object AnswerBox: TMemo
    Left = 32
    Top = 416
    Width = 65
    Height = 209
    Lines.Strings = (
      'AnswerBox')
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 112
    Top = 432
    Width = 49
    Height = 169
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
  object WorkMemo: TMemo
    Left = 192
    Top = 432
    Width = 121
    Height = 41
    Lines.Strings = (
      'WorkMemo')
    TabOrder = 4
  end
  object AnswerEdit: TEdit
    Left = 192
    Top = 480
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'AnswerEdit'
  end
  object Memo1: TMemo
    Left = 336
    Top = 416
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
  end
  object WinPanel: TPanel
    Left = 440
    Top = 456
    Width = 249
    Height = 161
    Caption = 'WinPanel'
    TabOrder = 7
    object WinText: TLabel
      Left = 16
      Top = 8
      Width = 93
      Height = 13
      Caption = 'Hooray you WON!!!'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 129
      Height = 13
      Caption = 'Retry with leftover chances'
    end
    object RestartButton: TButton
      Left = 8
      Top = 128
      Width = 75
      Height = 25
      Caption = 'RestartButton'
      TabOrder = 0
      OnClick = RestartButtonClick
    end
    object RetryPanel: TPanel
      Left = 8
      Top = 64
      Width = 233
      Height = 97
      Caption = 'RetryPanel'
      TabOrder = 2
      OnEnter = RetryPanelEnter
      object RetryLabel: TLabel
        Left = 0
        Top = 12
        Width = 50
        Height = 13
        Caption = 'Retry with '
      end
      object Label2: TLabel
        Left = 128
        Top = 34
        Width = 41
        Height = 13
        Caption = 'chances'
      end
      object RetryChances: TButton
        Left = 88
        Top = 64
        Width = 35
        Height = 25
        Caption = 'Retry'
        TabOrder = 0
        OnClick = RetryChancesClick
      end
      object RetryChancesEdit: TEdit
        Left = 88
        Top = 32
        Width = 33
        Height = 21
        TabOrder = 1
        Text = 'RetryChancesEdit'
        OnKeyPress = RetryChancesEditKeyPress
      end
      object ResetStatsCheck: TCheckBox
        Left = 72
        Top = 8
        Width = 129
        Height = 17
        Caption = 'Reset score stats'
        TabOrder = 2
      end
      object Button1: TButton
        Left = 6
        Top = 64
        Width = 67
        Height = 25
        Caption = '10 Chances'
        TabOrder = 3
        OnClick = TenChanceIntroClick
      end
      object Button2: TButton
        Left = 8
        Top = 32
        Width = 65
        Height = 25
        Caption = '5 Chances'
        TabOrder = 4
        OnClick = FiveChanceIntroClick
      end
      object Panel2: TPanel
        Left = 80
        Top = 32
        Width = 3
        Height = 97
        Caption = 'Panel1'
        Color = clBackground
        TabOrder = 5
      end
    end
    object Quit: TButton
      Left = 192
      Top = 128
      Width = 43
      Height = 25
      Caption = 'Quit'
      TabOrder = 1
      OnClick = QuitClick
    end
    object Dictionary: TButton
      Left = 130
      Top = 5
      Width = 51
      Height = 17
      Caption = 'Dictionary'
      TabOrder = 3
      OnClick = DictionaryClick
    end
  end
end
