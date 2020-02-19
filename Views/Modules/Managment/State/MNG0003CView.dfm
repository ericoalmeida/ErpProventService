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
              ExplicitHeight = 22
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
              object VwDadosSTATEID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'STATEID'
                HeaderAlignmentHorz = taCenter
              end
              object VwDadosNAME: TcxGridDBColumn
                Caption = 'Estado'
                DataBinding.FieldName = 'NAME'
                Width = 155
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
                Width = 155
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
