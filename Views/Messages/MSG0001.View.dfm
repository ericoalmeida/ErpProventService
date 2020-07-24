inherited FMSG0001View: TFMSG0001View
  Caption = 'Informa'#231#227'o'
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    inherited PnHeader: TRzPanel
      inherited LbTitle: TRzLabel
        Width = 107
        Caption = 'Informa'#231#227'o'
        ExplicitWidth = 107
      end
    end
    inherited PnContainerBody: TRzPanel
      inherited PnFooterBody: TRzPanel
        inherited PnButtonConfirm: TRzPanel
          Visible = False
        end
      end
      inherited PnContent: TRzPanel
        inherited MmMessage: TcxMemo
          Style.IsFontAssigned = True
        end
      end
    end
  end
end
