inherited FMSG0005View: TFMSG0005View
  Caption = 'Campos obrigat'#243'rios'
  ClientHeight = 323
  ClientWidth = 377
  ExplicitWidth = 383
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 375
    Height = 321
    ExplicitWidth = 375
    ExplicitHeight = 321
    inherited PnHeader: TRzPanel
      Width = 373
      ExplicitWidth = 373
      inherited LbTitle: TRzLabel
        Width = 189
        Caption = 'Campos obrigat'#243'rios'
        ExplicitWidth = 189
      end
    end
    inherited PnProgram: TRzPanel
      Top = 302
      Width = 373
      ExplicitTop = 302
      ExplicitWidth = 373
      inherited LbProgram: TRzLabel
        Width = 373
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 373
      Height = 261
      ExplicitWidth = 373
      ExplicitHeight = 261
      inherited PnFooterBody: TRzPanel
        Top = 221
        Width = 373
        ExplicitTop = 221
        ExplicitWidth = 373
        inherited PnButtonCancel: TRzPanel
          Left = 259
          ExplicitLeft = 259
        end
        inherited PnButtonConfirm: TRzPanel
          Left = 146
          Visible = False
          ExplicitLeft = 146
        end
      end
      inherited PnContent: TRzPanel
        Width = 371
        Height = 219
        ExplicitWidth = 371
        ExplicitHeight = 219
        inherited MmMessage: TcxMemo
          Lines.Strings = ()
          Style.Color = 4135182
          Style.TextColor = clWhite
          Style.IsFontAssigned = True
          StyleDisabled.Color = 4135182
          StyleDisabled.TextColor = clWhite
          ExplicitWidth = 371
          ExplicitHeight = 219
          Height = 219
          Width = 371
        end
      end
    end
  end
end
