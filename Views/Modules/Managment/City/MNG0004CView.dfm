inherited FMNG0004CView: TFMNG0004CView
  Caption = 'Pesquisa de Cidades'
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
      ExplicitWidth = 489
      inherited LbTitle: TRzLabel
        Width = 181
        Caption = 'Pesquisa de Cidades'
        ExplicitWidth = 181
      end
    end
    inherited PnProgram: TRzPanel
      Top = 300
      Width = 670
      ExplicitTop = 300
      ExplicitWidth = 489
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
        ExplicitWidth = 489
        inherited PnButtonCancel: TRzPanel
          Left = 556
          ExplicitLeft = 375
        end
        inherited PnButtonConfirm: TRzPanel
          Left = 443
          ExplicitLeft = 262
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
          ExplicitWidth = 485
        end
        inherited PnGrid: TRzPanel
          Width = 666
          Height = 143
          ExplicitWidth = 485
          ExplicitHeight = 143
          inherited DbDados: TcxGrid
            Width = 664
            Height = 141
            ExplicitWidth = 483
            ExplicitHeight = 141
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
                Width = 80
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
      'stt.name||'#39'/'#39'||stt.initials as statename,'
      'cty.createdat,'
      'cty.updatedat'
      ''
      'from'
      ''
      'TMNGCITY cty'
      'left join TMNGSTATE stt on (stt.code = cty.stateid)')
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
