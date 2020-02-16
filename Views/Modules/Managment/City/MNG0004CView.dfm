inherited FMNG0004CView: TFMNG0004CView
  Caption = 'Pesquisa de Cidades'
  ClientWidth = 493
  Visible = False
  OnShow = FormShow
  ExplicitWidth = 499
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 491
    inherited PnHeader: TRzPanel
      Width = 489
      inherited LbTitle: TRzLabel
        Width = 160
        Caption = 'Pesquisa de Cidades'
        ExplicitWidth = 160
      end
    end
    inherited PnProgram: TRzPanel
      Width = 489
      inherited LbProgram: TRzLabel
        Width = 489
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 489
      inherited PnFooterBody: TRzPanel
        Width = 489
        inherited BtSair: TcxButton
          Left = 379
        end
        inherited BtConfirmar: TcxButton
          Left = 271
        end
      end
      inherited PnContent: TRzPanel
        Width = 487
        inherited PnGridHeader: TRzPanel
          Width = 485
          inherited LbBuscar: TcxLabel
            Left = 158
            Style.IsFontAssigned = True
          end
          inherited PnBuscar: TRzPanel
            Left = 208
            inherited TxBuscar: TcxTextEdit
              Properties.OnChange = TxBuscarPropertiesChange
            end
          end
        end
        inherited PnGridFooter: TRzPanel
          Width = 485
          inherited LbTotalRegistros: TRzLabel
            Width = 477
            Height = 22
          end
        end
        inherited PnGrid: TRzPanel
          Width = 485
          inherited DbDados: TcxGrid
            Width = 483
            inherited VwDados: TcxGridDBTableView
              DataController.DataSource = DsData
              object VwDadosCITYID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'CITYID'
                Width = 60
              end
              object VwDadosNAME: TcxGridDBColumn
                Caption = 'Nome'
                DataBinding.FieldName = 'NAME'
                Width = 450
              end
              object VwDadosZIPCODE: TcxGridDBColumn
                Caption = 'CEP'
                DataBinding.FieldName = 'ZIPCODE'
                Width = 80
              end
              object VwDadosIBGECODE: TcxGridDBColumn
                Caption = 'C'#243'digo IBGE'
                DataBinding.FieldName = 'IBGECODE'
                Width = 60
              end
              object VwDadosSTATENAME: TcxGridDBColumn
                Caption = 'Estado'
                DataBinding.FieldName = 'STATENAME'
                Width = 150
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
      'cty.code,'
      'cty.cityid,'
      'cty.name,'
      'cty.zipcode,'
      'cty.ibgecode,'
      'cty.stateid,'
      'stt.descricao as statename,'
      'cty.createdat,'
      'cty.updatedat'
      ''
      'from'
      ''
      'TMNGCITY cty'
      'left join TGERESTADO stt on (stt.codigo = cty.stateid)')
    object FdQDataCODE: TStringField
      Alignment = taCenter
      FieldName = 'CODE'
      Size = 64
    end
    object FdQDataCITYID: TIntegerField
      FieldName = 'CITYID'
    end
    object FdQDataNAME: TStringField
      FieldName = 'NAME'
      Size = 155
    end
    object FdQDataZIPCODE: TStringField
      FieldName = 'ZIPCODE'
      EditMask = '00.000-000;0;_'
      Size = 12
    end
    object FdQDataIBGECODE: TIntegerField
      FieldName = 'IBGECODE'
    end
    object FdQDataSTATEID: TStringField
      FieldName = 'STATEID'
      Size = 64
    end
    object FdQDataSTATENAME: TStringField
      FieldName = 'STATENAME'
      Size = 90
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
