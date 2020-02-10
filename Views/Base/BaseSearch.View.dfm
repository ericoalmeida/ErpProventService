inherited FBaseSearchView: TFBaseSearchView
  Caption = 'FBaseSearchView'
  FormStyle = fsNormal
  WindowState = wsNormal
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    inherited PnHeader: TRzPanel
      inherited LbTitle: TRzLabel
        Width = 138
        Caption = 'Base search form'
        ExplicitWidth = 138
      end
    end
    inherited PnProgram: TRzPanel
      inherited LbProgram: TRzLabel
        Width = 608
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      object PnContent: TRzPanel
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 606
        Height = 195
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BorderOuter = fsNone
        BorderSides = [sdTop, sdBottom]
        BorderColor = 15066597
        BorderWidth = 1
        Color = clWhite
        TabOrder = 1
        object PnGridHeader: TRzPanel
          Left = 1
          Top = 1
          Width = 604
          Height = 38
          Align = alTop
          BorderOuter = fsNone
          BorderSides = [sdBottom]
          BorderColor = 16315375
          BorderWidth = 1
          Color = 16579836
          TabOrder = 0
          DesignSize = (
            604
            38)
          object LbBuscar: TcxLabel
            Left = 277
            Top = 8
            Anchors = [akRight, akBottom]
            Caption = 'Buscar:'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Open Sans'
            Style.Font.Style = []
            Style.IsFontAssigned = True
          end
          object PnBuscar: TRzPanel
            AlignWithMargins = True
            Left = 327
            Top = 7
            Width = 273
            Height = 24
            Margins.Top = 6
            Margins.Bottom = 6
            Align = alRight
            BorderOuter = fsNone
            BorderColor = 15314790
            BorderWidth = 1
            Color = clWhite
            TabOrder = 1
            object TxBuscar: TcxTextEdit
              Left = 1
              Top = 1
              Align = alClient
              Style.BorderStyle = ebsNone
              TabOrder = 0
              Width = 271
            end
          end
        end
        object PnGridFooter: TRzPanel
          Left = 1
          Top = 164
          Width = 604
          Height = 30
          Align = alBottom
          BorderOuter = fsNone
          BorderSides = [sdTop]
          BorderColor = 16315375
          BorderWidth = 1
          Color = 16119285
          TabOrder = 1
          object LbTotalRegistros: TRzLabel
            AlignWithMargins = True
            Left = 4
            Top = 5
            Width = 596
            Height = 22
            Margins.Top = 4
            Margins.Bottom = 2
            Align = alClient
            Caption = 'Mostrando de 0 at'#233' 0 de 0 registros'
            Font.Charset = ANSI_CHARSET
            Font.Color = 5592405
            Font.Height = -12
            Font.Name = 'Open Sans'
            Font.Style = []
            ParentFont = False
            BorderColor = 15066597
            ExplicitWidth = 199
            ExplicitHeight = 17
          end
        end
        object PnGrid: TRzPanel
          AlignWithMargins = True
          Left = 1
          Top = 41
          Width = 604
          Height = 121
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alClient
          BorderOuter = fsNone
          BorderColor = 15066597
          BorderWidth = 1
          Color = clWhite
          TabOrder = 2
          object DbDados: TcxGrid
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 602
            Height = 119
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = cxcbsNone
            TabOrder = 0
            LookAndFeel.Kind = lfStandard
            LookAndFeel.NativeStyle = False
            object VwDados: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
              OptionsView.CellAutoHeight = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Styles.Header = StHeader
            end
            object LvDados: TcxGridLevel
              GridView = VwDados
            end
          end
        end
      end
    end
  end
  object FdDados: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 116
    Top = 140
  end
  object DsDados: TDataSource
    DataSet = FdDados
    Left = 156
    Top = 140
  end
  object StGridStyles: TcxStyleRepository
    Left = 144
    Top = 96
    PixelsPerInch = 96
    object StHeader: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16579836
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Open Sans'
      Font.Style = [fsBold]
      TextColor = 5592405
    end
  end
end
