inherited FMNG0003BView: TFMNG0003BView
  Caption = 'Estados'
  ClientHeight = 280
  ClientWidth = 487
  Visible = False
  ExplicitWidth = 493
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 485
    Height = 278
    inherited PnHeader: TRzPanel
      Width = 483
      inherited LbTitle: TRzLabel
        Width = 62
        Height = 26
        Caption = 'Estados'
        ExplicitWidth = 62
      end
      inherited LbOperation: TRzLabel
        Left = 399
        Height = 26
      end
    end
    inherited PnProgram: TRzPanel
      Top = 259
      Width = 483
      inherited LbProgram: TRzLabel
        Width = 483
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 483
      Height = 218
      inherited PnFooterBody: TRzPanel
        Top = 178
        Width = 483
        inherited BtSair: TcxButton
          Left = 373
        end
        inherited BtConfirmar: TcxButton
          Left = 265
        end
      end
      inherited PnContent: TRzPanel
        Width = 479
        Height = 174
        inherited RzLabel1: TRzLabel
          Top = 161
          Width = 479
        end
        object TxUpdatedDate: TcxTextEdit
          Left = 91
          Top = 121
          Enabled = False
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Width = 214
        end
        object cxLabel2: TcxLabel
          Left = 4
          Top = 122
          Caption = 'Atualizado em:'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = []
          Style.IsFontAssigned = True
        end
        object TxCreatedDate: TcxTextEdit
          Left = 91
          Top = 97
          Enabled = False
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 2
          Width = 214
        end
        object cxLabel1: TcxLabel
          Left = 25
          Top = 98
          Caption = 'Criado em:'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = []
          Style.IsFontAssigned = True
        end
        object TxCountryName: TcxTextEdit
          Left = 148
          Top = 49
          Enabled = False
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 4
          Width = 276
        end
        object TxCountryId: TcxButtonEdit
          Left = 91
          Top = 49
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.NativeStyle = False
          Style.ButtonStyle = bts3D
          Style.ButtonTransparency = ebtAlways
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.Color = 16577771
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 5
          Width = 54
        end
        object cxLabel3: TcxLabel
          Left = 41
          Top = 51
          Caption = 'Pa'#237's:'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
        end
        object TxDescription: TcxTextEdit
          Left = 91
          Top = 25
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.Color = 16577771
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 7
          Width = 333
        end
        object LbDescription: TcxLabel
          Left = 25
          Top = 26
          Caption = 'Descri'#231#227'o:'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
        end
        object TxStateId: TcxTextEdit
          Left = 91
          Top = 1
          Enabled = False
          Properties.CharCase = ecUpperCase
          Style.BorderColor = 12698049
          Style.BorderStyle = ebsSingle
          Style.HotTrack = False
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.BorderColor = 12698049
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.TextColor = clBlack
          StyleFocused.BorderColor = 15314790
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 9
          Width = 118
        end
        object LbDistrictId: TcxLabel
          Left = 66
          Top = 2
          Caption = 'N'#186':'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = []
          Style.IsFontAssigned = True
        end
      end
    end
  end
end
