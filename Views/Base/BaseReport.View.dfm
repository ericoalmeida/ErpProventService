object FBaseReportView: TFBaseReportView
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'FBaseReportView'
  ClientHeight = 336
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object RpBaseView: TRLReport
    Left = 1
    Top = 0
    Width = 794
    Height = 1123
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Open Sans'
    Font.Style = []
    object RpPageHeader: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      BandType = btHeader
      object RLDBText3: TRLDBText
        Left = 168
        Top = 24
        Width = 135
        Height = 17
        DataField = 'COMPANYFANCYNAME'
        DataSource = DsData
        Text = ''
      end
    end
    object RpGroup: TRLGroup
      Left = 38
      Top = 97
      Width = 718
      Height = 224
      object RlHeader: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 16
        BandType = btHeader
      end
      object RpDetail: TRLBand
        Left = 0
        Top = 16
        Width = 718
        Height = 65
      end
      object RpFooter: TRLBand
        Left = 0
        Top = 81
        Width = 718
        Height = 16
        BandType = btFooter
      end
    end
  end
  object FdQData: TFDQuery
    Connection = FDConnection1
    Left = 116
    Top = 173
  end
  object DsData: TDataSource
    DataSet = FdQData
    Left = 204
    Top = 180
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\ErpProvideService\dados\ERGDADOS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 71
    Top = 217
  end
end
