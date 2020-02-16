inherited FMNG0003CView: TFMNG0003CView
  Caption = 'Pesquisa de Estados'
  ClientWidth = 474
  Visible = False
  OnShow = FormShow
  ExplicitWidth = 480
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 472
    ExplicitWidth = 472
    inherited PnHeader: TRzPanel
      Width = 470
      ExplicitWidth = 470
      inherited LbTitle: TRzLabel
        Width = 160
        Caption = 'Pesquisa de Estados'
        ExplicitWidth = 160
      end
    end
    inherited PnProgram: TRzPanel
      Width = 470
      ExplicitWidth = 470
      inherited LbProgram: TRzLabel
        Width = 470
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 470
      ExplicitWidth = 470
      inherited PnFooterBody: TRzPanel
        Width = 470
        ExplicitWidth = 470
        inherited BtSair: TcxButton
          Left = 360
          ExplicitLeft = 360
        end
        inherited BtConfirmar: TcxButton
          Left = 252
          ExplicitLeft = 252
        end
      end
      inherited PnContent: TRzPanel
        Width = 468
        ExplicitWidth = 468
        inherited PnGridHeader: TRzPanel
          Width = 466
          ExplicitWidth = 466
          inherited LbBuscar: TcxLabel
            Left = 139
            Style.IsFontAssigned = True
            ExplicitLeft = 139
          end
          inherited PnBuscar: TRzPanel
            Left = 189
            ExplicitLeft = 189
            inherited TxBuscar: TcxTextEdit
              Properties.OnChange = TxBuscarPropertiesChange
            end
          end
        end
        inherited PnGridFooter: TRzPanel
          Width = 466
          ExplicitWidth = 466
          inherited LbTotalRegistros: TRzLabel
            Width = 458
            Height = 22
          end
        end
        inherited PnGrid: TRzPanel
          Width = 466
          ExplicitWidth = 466
          inherited DbDados: TcxGrid
            Width = 464
            ExplicitWidth = 464
            inherited VwDados: TcxGridDBTableView
              DataController.DataSource = DsData
              object VwDadosESTADOID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'ESTADOID'
                HeaderGlyphAlignmentHorz = taCenter
              end
              object VwDadosDESCRICAO: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESCRICAO'
              end
              object VwDadosPAISDESCRICAO: TcxGridDBColumn
                Caption = 'Pa'#237's'
                DataBinding.FieldName = 'PAISDESCRICAO'
                Width = 200
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
      'est.codigo,'
      'est.estadoid,'
      'est.descricao,'
      'est.paisid,'
      'pai.descricao as paisdescricao,'
      'est.datacadastro,'
      'est.dataatualizacao'
      ''
      'from'
      ''
      'tgerestado est'
      'left join tgerpais pai on (pai.codigo = est.paisid)')
    object FdQDataCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 64
    end
    object FdQDataESTADOID: TIntegerField
      Alignment = taCenter
      FieldName = 'ESTADOID'
    end
    object FdQDataDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 90
    end
    object FdQDataPAISID: TStringField
      FieldName = 'PAISID'
      Size = 64
    end
    object FdQDataPAISDESCRICAO: TStringField
      FieldName = 'PAISDESCRICAO'
      Size = 60
    end
    object FdQDataDATACADASTRO: TSQLTimeStampField
      FieldName = 'DATACADASTRO'
    end
    object FdQDataDATAATUALIZACAO: TSQLTimeStampField
      FieldName = 'DATAATUALIZACAO'
    end
  end
  inherited StGridStyles: TcxStyleRepository
    PixelsPerInch = 96
  end
end
