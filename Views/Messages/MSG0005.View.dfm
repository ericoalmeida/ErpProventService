inherited FMSG0005View: TFMSG0005View
  Caption = 'Campos obrigat'#243'rios'
  ClientHeight = 323
  ClientWidth = 377
  ExplicitWidth = 383
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 375
    Height = 321
    inherited PnHeader: TRzPanel
      Width = 373
      inherited LbTitle: TRzLabel
        Width = 166
        Caption = 'Campos obrigat'#243'rios'
        ExplicitWidth = 166
      end
    end
    inherited PnProgram: TRzPanel
      Top = 302
      Width = 373
      inherited LbProgram: TRzLabel
        Width = 373
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 373
      Height = 261
      inherited PnFooterBody: TRzPanel
        Top = 221
        Width = 373
        inherited PnButtonCancel: TRzPanel
          Left = 259
        end
        inherited PnButtonConfirm: TRzPanel
          Left = 146
          Visible = False
          ExplicitLeft = 220
          ExplicitTop = 4
          inherited BtConfirmar: TcxButton
            ExplicitLeft = 2
            ExplicitWidth = 106
          end
        end
      end
      inherited PnContent: TRzPanel
        Width = 371
        Height = 219
        inherited MmMessage: TcxMemo
          Lines.Strings = ()
          Style.Color = 4135182
          Style.TextColor = clWhite
          Style.IsFontAssigned = True
          StyleDisabled.Color = 4135182
          StyleDisabled.TextColor = clWhite
          Height = 219
          Width = 371
        end
      end
    end
  end
end
