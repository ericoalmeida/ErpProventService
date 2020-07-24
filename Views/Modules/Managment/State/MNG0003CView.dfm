inherited FMNG0003CView: TFMNG0003CView
  Caption = 'Pesquisa de Estados'
  ClientHeight = 321
  ClientWidth = 674
  Visible = False
  OnShow = FormShow
  ExplicitWidth = 680
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 672
    Height = 319
    ExplicitWidth = 672
    ExplicitHeight = 319
    inherited PnHeader: TRzPanel
      Width = 670
      ExplicitWidth = 470
      inherited LbTitle: TRzLabel
        Width = 183
        Caption = 'Pesquisa de Estados'
        ExplicitWidth = 183
      end
    end
    inherited PnProgram: TRzPanel
      Top = 300
      Width = 670
      ExplicitTop = 300
      ExplicitWidth = 470
    end
    inherited PnContainerBody: TRzPanel
      Width = 670
      Height = 259
      ExplicitWidth = 670
      ExplicitHeight = 259
      inherited PnFooterBody: TRzPanel
        Top = 219
        Width = 670
        ExplicitTop = 219
        ExplicitWidth = 470
        inherited PnButtonCancel: TRzPanel
          Left = 556
          ExplicitLeft = 356
        end
        inherited PnButtonConfirm: TRzPanel
          Left = 443
          ExplicitLeft = 243
        end
      end
      inherited PnContent: TRzPanel
        Width = 668
        Height = 217
        ExplicitWidth = 668
        ExplicitHeight = 217
        inherited PnGridHeader: TRzPanel
          Width = 666
          ExplicitWidth = 666
          inherited LbBuscar: TcxLabel
            Left = 339
            Style.IsFontAssigned = True
            ExplicitLeft = 339
          end
          inherited TxBuscar: TcxTextEdit
            Left = 388
            Properties.OnChange = TxBuscarPropertiesChange
            ExplicitLeft = 388
          end
        end
        inherited PnGridFooter: TRzPanel
          Top = 186
          Width = 666
          ExplicitTop = 186
          ExplicitWidth = 466
        end
        inherited PnGrid: TRzPanel
          Width = 666
          Height = 143
          ExplicitWidth = 466
          ExplicitHeight = 143
          inherited DbDados: TcxGrid
            Width = 664
            Height = 141
            ExplicitWidth = 464
            ExplicitHeight = 141
            inherited VwDados: TcxGridDBTableView
              DataController.DataSource = DsData
              object VwDadosSTATEID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'STATEID'
                HeaderAlignmentHorz = taCenter
              end
              object VwDadosNAME: TcxGridDBColumn
                Caption = 'Estado'
                DataBinding.FieldName = 'NAME'
                Width = 185
              end
              object VwDadosCOUNTRYNAME: TcxGridDBColumn
                Caption = 'Pa'#237's'
                DataBinding.FieldName = 'COUNTRYNAME'
                Width = 155
              end
              object VwDadosCREATEDAT: TcxGridDBColumn
                Caption = 'Data Cadastro'
                DataBinding.FieldName = 'CREATEDAT'
                Width = 110
              end
              object VwDadosUPDATEDAT: TcxGridDBColumn
                Caption = 'Ult. Atualiza'#231#227'o'
                DataBinding.FieldName = 'UPDATEDAT'
                Width = 110
              end
            end
          end
        end
      end
    end
  end
  inherited DsData: TDataSource
    DataSet = FdQData
  end
  inherited FdQData: TFDQuery
    SQL.Strings = (
      'select'
      ''
      'stt.code,'
      'stt.stateid,'
      'stt.name,'
      'stt.countryid,'
      'ctr.name  as countryName,'
      'stt.createdat,'
      'stt.updatedat'
      ''
      'from'
      ''
      'TMNGSTATE stt'
      'left join TMNGCOUNTRY ctr on (ctr.code = stt.countryid)')
    object FdQDataCODE: TStringField
      FieldName = 'CODE'
      Size = 64
    end
    object FdQDataSTATEID: TIntegerField
      FieldName = 'STATEID'
    end
    object FdQDataNAME: TStringField
      FieldName = 'NAME'
      Size = 90
    end
    object FdQDataCOUNTRYID: TStringField
      FieldName = 'COUNTRYID'
      Size = 64
    end
    object FdQDataCOUNTRYNAME: TStringField
      FieldName = 'COUNTRYNAME'
      Size = 60
    end
    object FdQDataCREATEDAT: TSQLTimeStampField
      FieldName = 'CREATEDAT'
    end
    object FdQDataUPDATEDAT: TSQLTimeStampField
      FieldName = 'UPDATEDAT'
    end
  end
  inherited StGridStyles: TcxStyleRepository
    PixelsPerInch = 96
  end
end
