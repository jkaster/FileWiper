object FormFileWiper: TFormFileWiper
  Left = 277
  Top = 112
  Width = 560
  Height = 205
  Caption = 'File Wiper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblFile: TLabel
    Left = 12
    Top = 12
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'File to Wipe'
    FocusControl = eFileName
    Transparent = True
  end
  object lblSize: TLabel
    Left = 17
    Top = 40
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'Size of File'
    FocusControl = eSize
    Transparent = True
  end
  object Label1: TLabel
    Left = 20
    Top = 64
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Drive Size'
    Transparent = True
  end
  object lblDriveSize: TLabel
    Left = 72
    Top = 64
    Width = 59
    Height = 13
    Caption = 'Drive Size'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblFreeSpace: TLabel
    Left = 72
    Top = 80
    Width = 66
    Height = 13
    Caption = 'Free Space'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 13
    Top = 80
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'Free Space'
    Transparent = True
  end
  object eFileName: TEdit
    Left = 72
    Top = 8
    Width = 387
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'c:\wipeme.txt'
    OnChange = eFileNameChange
  end
  object btnBrowse: TButton
    Left = 467
    Top = 8
    Width = 74
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Browse'
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object eSize: TEdit
    Left = 72
    Top = 36
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object btnWipe: TButton
    Left = 72
    Top = 104
    Width = 75
    Height = 25
    Action = actWipe
    TabOrder = 3
  end
  object btnClose: TButton
    Left = 152
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object pbWiping: TProgressBar
    Left = 72
    Top = 132
    Width = 467
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    Min = 0
    Max = 100
    TabOrder = 5
  end
  object odWipe: TOpenDialog
    Title = 'Select the File to Wipe'
    Left = 468
    Top = 40
  end
  object ActionList1: TActionList
    Left = 500
    Top = 40
    object actWipe: TAction
      Caption = '&Wipe'
      Enabled = False
      OnExecute = actWipeExecute
      OnHint = actWipeHint
      OnUpdate = actWipeUpdate
    end
  end
end
