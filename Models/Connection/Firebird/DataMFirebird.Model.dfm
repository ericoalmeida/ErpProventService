object FDataMFirebird: TFDataMFirebird
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 198
  Width = 264
  object FDatabase: TFDConnection
    Left = 32
    Top = 8
  end
  object DriverLink: TFDPhysFBDriverLink
    Left = 32
    Top = 72
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 112
    Top = 32
  end
end
