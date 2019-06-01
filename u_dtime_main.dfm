object frmDTime: TfrmDTime
  Left = 468
  Top = 298
  Width = 389
  Height = 187
  Caption = #23450#26102
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblShow: TLabel
    Left = 16
    Top = 8
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 90
    Top = 95
    Width = 12
    Height = 13
    Caption = #20998
  end
  object Label2: TLabel
    Left = 10
    Top = 95
    Width = 24
    Height = 13
    Caption = #23450#26102
  end
  object btnStart: TButton
    Left = 168
    Top = 88
    Width = 75
    Height = 41
    Hint = #24320#22987#25353' '#23450#26102' '#24320#22987#35745#26102#65292#26102#38388#21040#21518#20250' '#25552#31034#21040#26368#21069#38754
    Caption = #24320#22987'(&S)'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 256
    Top = 88
    Width = 75
    Height = 41
    Hint = #32467#26463#26412#36718#35745#26102
    Caption = #32467#26463'(&T)'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object edtSJ: TEdit
    Left = 42
    Top = 93
    Width = 41
    Height = 21
    Hint = #21462#20540#33539#22260' 0.05~10000'
    TabOrder = 2
    Text = '30'
  end
  object chkAutoStart: TCheckBox
    Left = 10
    Top = 120
    Width = 135
    Height = 17
    Hint = #24403#19968#27425#35745#26102#32467#26463#26102#65292#26159#21542#33258#21160#24320#22987#19979#19968#27425#35745#26102
    Caption = #33258#21160#24320#22987#19979#27425#35745#26102
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 280
    Top = 32
  end
end
