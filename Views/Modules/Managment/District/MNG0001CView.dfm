inherited FMNG0001CView: TFMNG0001CView
  Caption = 'Bairros'
  ClientHeight = 291
  ClientWidth = 674
  Visible = False
  OnShow = FormShow
  ExplicitWidth = 680
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 672
    Height = 289
    ExplicitWidth = 672
    ExplicitHeight = 289
    inherited PnHeader: TRzPanel
      Width = 670
      ExplicitWidth = 670
      inherited LbTitle: TRzLabel
        Width = 175
        Caption = 'Pesquisa de bairros'
        ExplicitWidth = 175
      end
    end
    inherited PnProgram: TRzPanel
      Top = 270
      Width = 670
      ExplicitTop = 300
      ExplicitWidth = 670
    end
    inherited PnContainerBody: TRzPanel
      Width = 670
      Height = 229
      ExplicitWidth = 670
      ExplicitHeight = 229
      inherited PnFooterBody: TRzPanel
        Top = 189
        Width = 670
        ExplicitTop = 219
        ExplicitWidth = 670
        inherited PnButtonCancel: TRzPanel
          Left = 556
          ExplicitLeft = 556
        end
        inherited PnButtonConfirm: TRzPanel
          Left = 443
          ExplicitLeft = 443
        end
      end
      inherited PnContent: TRzPanel
        Width = 668
        Height = 187
        ExplicitWidth = 668
        ExplicitHeight = 187
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
            ExplicitHeight = 24
          end
        end
        inherited PnGridFooter: TRzPanel
          Top = 156
          Width = 666
          ExplicitTop = 186
          ExplicitWidth = 666
        end
        inherited PnGrid: TRzPanel
          Width = 666
          Height = 113
          ExplicitWidth = 666
          ExplicitHeight = 143
          inherited DbDados: TcxGrid
            Width = 664
            Height = 111
            ExplicitWidth = 664
            ExplicitHeight = 141
            inherited VwDados: TcxGridDBTableView
              DataController.DataSource = DsData
              object VwDadosDISTRICTID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'DISTRICTID'
                HeaderAlignmentHorz = taCenter
                Width = 50
              end
              object VwDadosDESCRIPTION: TcxGridDBColumn
                Caption = 'Bairro'
                DataBinding.FieldName = 'DESCRIPTION'
                Width = 295
              end
              object VwDadosCITYNAME: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'CITYNAME'
                Width = 255
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
      'dtr.code,'
      'dtr.districtid,'
      'dtr.description,'
      'dtr.cityid,'
      'cty.name||'#39'/'#39'||stt.initials  as cityname,'
      'dtr.createdat,'
      'dtr.updatedat'
      ''
      'from'
      ''
      'TMngDistrict dtr'
      'left join TMngCity cty on (cty.code = dtr.cityid)'
      'left join TMngState stt on (stt.code = cty.stateid)')
    object FdQDataCODE: TStringField
      Alignment = taCenter
      FieldName = 'CODE'
      Size = 64
    end
    object FdQDataDISTRICTID: TIntegerField
      Alignment = taCenter
      FieldName = 'DISTRICTID'
    end
    object FdQDataDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 155
    end
    object FdQDataCITYID: TStringField
      FieldName = 'CITYID'
      Size = 64
    end
    object FdQDataCITYNAME: TStringField
      FieldName = 'CITYNAME'
      Size = 155
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
