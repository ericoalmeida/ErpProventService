inherited FMNG0001BView: TFMNG0001BView
  Caption = 'Bairros'
  ClientHeight = 227
  ClientWidth = 449
  Visible = False
  ExplicitWidth = 455
  ExplicitHeight = 256
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 447
    Height = 225
    inherited PnHeader: TRzPanel
      Width = 445
      inherited LbTitle: TRzLabel
        Width = 58
        Caption = 'Bairros'
        ExplicitWidth = 58
      end
      inherited LbOperation: TRzLabel
        Left = 361
      end
    end
    inherited PnProgram: TRzPanel
      Top = 206
      Width = 445
      inherited LbProgram: TRzLabel
        Width = 445
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 445
      Height = 165
      inherited PnFooterBody: TRzPanel
        Top = 125
        Width = 445
        inherited BtSair: TcxButton
          Left = 335
        end
        inherited BtConfirmar: TcxButton
          Left = 227
          OnClick = BtConfirmarClick
        end
      end
      inherited PnContent: TRzPanel
        Width = 441
        Height = 121
        inherited RzLabel1: TRzLabel
          Top = 108
          Width = 441
          ExplicitTop = 106
        end
        object TxDistrictId: TRzEdit
          Left = 66
          Top = 2
          Width = 121
          Height = 21
          Text = ''
          CharCase = ecUpperCase
          Ctl3D = False
          Enabled = False
          FrameColor = clBlack
          ParentCtl3D = False
          TabOrder = 0
        end
        object TxDescription: TRzEdit
          Left = 66
          Top = 29
          Width = 368
          Height = 21
          Text = ''
          CharCase = ecUpperCase
          Ctl3D = False
          FrameColor = clBlack
          ParentCtl3D = False
          TabOrder = 1
        end
        object LbDistrictId: TcxLabel
          Left = 41
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
        object LbDescription: TcxLabel
          Left = 4
          Top = 29
          Caption = 'Descri'#231#227'o:'
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Open Sans'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
        end
      end
    end
  end
end
