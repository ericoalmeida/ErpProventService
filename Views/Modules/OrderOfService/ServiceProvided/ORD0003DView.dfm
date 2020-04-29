inherited FBaseReportView1: TFBaseReportView1
  Caption = 'Rela'#231#226'o de ordens de servi'#231'o'
  PixelsPerInch = 96
  TextHeight = 13
  inherited RpBaseView: TRLReport
    DataSource = DsData
    inherited RpPageHeader: TRLBand
      Height = 91
      ExplicitHeight = 91
      object RLDBText1: TRLDBText [0]
        Left = 3
        Top = 28
        Width = 187
        Height = 18
        DataField = 'COMPANYNAME'
        DataSource = DsData
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Open Sans SemiBold'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Text = ''
      end
      inherited RLDBText3: TRLDBText
        Left = 3
        Top = 11
        Width = 187
        Height = 22
        Font.Height = -16
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 3
        ExplicitTop = 11
        ExplicitWidth = 187
        ExplicitHeight = 22
      end
      object RLLabel1: TRLLabel
        Left = 267
        Top = 58
        Width = 214
        Height = 20
        Caption = 'Rela'#231#227'o de servi'#231'os prestados'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Open Sans'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
    end
    inherited RpGroup: TRLGroup
      Top = 129
      AllowedBands = [btHeader, btTitle, btColumnHeader, btDetail, btColumnFooter, btSummary, btFooter]
      MaxBands = 10
      MinBands = 1
      ExplicitTop = 129
      inherited RlHeader: TRLBand
        Height = 25
        ExplicitHeight = 25
        object RLPanel1: TRLPanel
          Left = -4
          Top = 2
          Width = 727
          Height = 21
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Borders.Color = 2434341
          object RLLabel2: TRLLabel
            Left = 140
            Top = 1
            Width = 88
            Height = 17
            Caption = 'Produtor Rural'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel3: TRLLabel
            Left = 647
            Top = 1
            Width = 70
            Height = 17
            Alignment = taRightJustify
            Caption = 'Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel4: TRLLabel
            Left = 570
            Top = 0
            Width = 69
            Height = 17
            Alignment = taRightJustify
            Caption = 'Total Horas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel5: TRLLabel
            Left = 500
            Top = 1
            Width = 54
            Height = 17
            Alignment = taRightJustify
            Caption = 'Total KM'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel6: TRLLabel
            Left = 4
            Top = 1
            Width = 58
            Height = 17
            Caption = 'N'#250'mero'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel7: TRLLabel
            Left = 65
            Top = 1
            Width = 31
            Height = 17
            Caption = 'Data'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Open Sans SemiBold'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      inherited RpDetail: TRLBand
        Top = 25
        Height = 19
        ExplicitTop = 25
        ExplicitHeight = 19
        object RLDBText2: TRLDBText
          Left = 0
          Top = 1
          Width = 58
          Height = 15
          DataField = 'SERVICEPROVIDEDID'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 136
          Top = 1
          Width = 70
          Height = 15
          DataField = 'CLIENTNAME'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 643
          Top = 1
          Width = 71
          Height = 15
          Alignment = taRightJustify
          DataField = 'TOTAL'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 487
          Top = 1
          Width = 63
          Height = 15
          Alignment = taRightJustify
          DataField = 'TOTALKM'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText7: TRLDBText
          Left = 560
          Top = 0
          Width = 75
          Height = 15
          Alignment = taRightJustify
          DataField = 'TOTALHOURS'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText8: TRLDBText
          Left = 61
          Top = 1
          Width = 71
          Height = 15
          DataField = 'PROVIDEDAT'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText9: TRLDBText
          Left = 336
          Top = 0
          Width = 45
          Height = 15
          DataField = 'SERVICE'
          DataSource = DsData
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Open Sans'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      inherited RpFooter: TRLBand
        Top = 44
        Height = 40
        ExplicitTop = 44
        ExplicitHeight = 40
        object RLPanel2: TRLPanel
          Left = -11
          Top = 2
          Width = 742
          Height = 21
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.Color = 2434341
        end
      end
    end
  end
  inherited FdQData: TFDQuery
    Active = True
    SQL.Strings = (
      'Select'
      ''
      'Mng.name as companyName,'
      'Mng.fancyname as companyFancyName,'
      'lpad(Ord.serviceprovidedid, 8, '#39'0'#39') as serviceProvidedId,'
      'Ord.providedat,'
      'Prs.name as clientName,'
      'Srv.description as service,'
      'Ord.totalkm,'
      'lpad((ord.totalhours / 3600), 2, '#39'0'#39')||'#39':'#39'||'
      'lpad((mod(ord.totalhours, 3600) / 60), 2, '#39'0'#39')||'#39':'#39'||'
      'lpad(mod(mod(ord.totalhours, 3600), 60),2, '#39'0'#39') as totalhours,'
      'Ord.total'
      ''
      'from'
      ''
      'TMngCompany Mng'
      'left join TOrdServicesProvided Ord on (Ord.companyid = Mng.code)'
      
        'left join TMngPerson Prs on (Prs.companyid = Ord.companyid)and(P' +
        'rs.code = Ord.clientid)'
      
        'left join TOrdService Srv on (Srv.companyid = Ord.companyid)and(' +
        'Srv.code = Ord.serviceid)')
    object FdQDataCOMPANYNAME: TStringField
      FieldName = 'COMPANYNAME'
      Size = 190
    end
    object FdQDataCOMPANYFANCYNAME: TStringField
      FieldName = 'COMPANYFANCYNAME'
      Size = 190
    end
    object FdQDataSERVICEPROVIDEDID: TStringField
      FieldName = 'SERVICEPROVIDEDID'
      Size = 8
    end
    object FdQDataPROVIDEDAT: TDateField
      FieldName = 'PROVIDEDAT'
    end
    object FdQDataCLIENTNAME: TStringField
      FieldName = 'CLIENTNAME'
      Size = 190
    end
    object FdQDataTOTALKM: TFMTBCDField
      FieldName = 'TOTALKM'
      DisplayFormat = '0.0Km'
      Size = 1
    end
    object FdQDataTOTALHOURS: TStringField
      FieldName = 'TOTALHOURS'
      Size = 8
    end
    object FdQDataTOTAL: TFMTBCDField
      FieldName = 'TOTAL'
      Size = 18
    end
    object FdQDataSERVICE: TStringField
      FieldName = 'SERVICE'
      Size = 95
    end
  end
end
