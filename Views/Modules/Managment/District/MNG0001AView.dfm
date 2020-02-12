inherited FMNG0001AView: TFMNG0001AView
  Caption = ''
  ClientHeight = 292
  ClientWidth = 488
  OnShow = FormShow
  ExplicitWidth = 494
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    Width = 486
    Height = 290
    inherited PnHeader: TRzPanel
      Width = 484
      inherited LbTitle: TRzLabel
        Width = 58
        Caption = 'Bairros'
        ExplicitWidth = 58
      end
    end
    inherited PnProgram: TRzPanel
      Top = 271
      Width = 484
      inherited LbProgram: TRzLabel
        Width = 484
      end
    end
    inherited PnContainerBody: TRzPanel
      Width = 484
      Height = 230
      inherited PnFooterBody: TRzPanel
        Top = 190
        Width = 484
        inherited BtSair: TcxButton
          Left = 374
        end
      end
      inherited PnContent: TRzPanel
        Width = 482
        Height = 137
        inherited PnGridHeader: TRzPanel
          Width = 480
          inherited LbBuscar: TcxLabel
            Left = 153
            Style.IsFontAssigned = True
          end
          inherited PnBuscar: TRzPanel
            Left = 203
            inherited TxBuscar: TcxTextEdit
              Properties.CharCase = ecUpperCase
            end
          end
        end
        inherited PnGridFooter: TRzPanel
          Top = 106
          Width = 480
          inherited LbTotalRegistros: TRzLabel
            Width = 472
          end
        end
        inherited PnGrid: TRzPanel
          Width = 480
          Height = 63
          inherited DbDados: TcxGrid
            Width = 478
            Height = 61
            inherited VwDados: TcxGridDBTableView
              DataController.DataSource = DsData
              object VwDadosBAIRROID: TcxGridDBColumn
                Caption = 'N'#186
                DataBinding.FieldName = 'BAIRROID'
                HeaderAlignmentHorz = taCenter
                Width = 60
              end
              object VwDadosDESCRICAO: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESCRICAO'
                Width = 550
              end
              object VwDadosDATACADASTRO: TcxGridDBColumn
                Caption = 'Data Cadastro'
                DataBinding.FieldName = 'DATACADASTRO'
                Width = 110
              end
              object VwDadosDATAATUALIZACAO: TcxGridDBColumn
                Caption = 'Data Atualiza'#231#227'o'
                DataBinding.FieldName = 'DATAATUALIZACAO'
                Width = 110
              end
            end
          end
        end
      end
      inherited PnHeaderButtons: TRzPanel
        Width = 482
      end
    end
  end
  inherited StGridStyles: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited FdData: TFDMemTable
    object FdDataCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 64
    end
    object FdDataBAIRROID: TIntegerField
      FieldName = 'BAIRROID'
    end
    object FdDataDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 155
    end
    object FdDataDATACADASTRO: TDateTimeField
      FieldName = 'DATACADASTRO'
    end
    object FdDataDATAATUALIZACAO: TDateTimeField
      FieldName = 'DATAATUALIZACAO'
    end
  end
end
