inherited FBaseRegisterView: TFBaseRegisterView
  Caption = 'FBaseRegisterView'
  FormStyle = fsNormal
  WindowState = wsNormal
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnContainer: TRzPanel
    inherited PnHeader: TRzPanel
      inherited LbTitle: TRzLabel
        Width = 146
        Caption = 'Base register form'
        ExplicitWidth = 146
      end
    end
    inherited PnProgram: TRzPanel
      inherited LbProgram: TRzLabel
        Width = 608
        Height = 18
      end
    end
    inherited PnContainerBody: TRzPanel
      inherited PnFooterBody: TRzPanel
        inherited BtSair: TcxButton
          Margins.Left = 0
          Caption = 'C&ancelar'
        end
        object BtConfirmar: TcxButton
          AlignWithMargins = True
          Left = 390
          Top = 2
          Width = 108
          Height = 36
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alRight
          Caption = '&Confirmar'
          LookAndFeel.Kind = lfOffice11
          LookAndFeel.NativeStyle = False
          LookAndFeel.ScrollbarMode = sbmDefault
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000015744558745469746C6500436865636B3B4D61726B3B5469636B0B00
            C7240000026B49444154785E95924D48156B18C77F338D7A94B436816090828B
            8B94919BBE886304C5599CEA9A14145177211246AB3641F6B16861044610B408
            23C842FB2410B4ACB06BDDD55510823072532267A19E93E76BE6FDCAF3323910
            44F4303CFF7786797EFFE77978BD9B2FF6BE715DA7955F8589040CC63818345A
            99B13389D13D5EA9B87DDB05FE341EFC7B310EB89E5286824A912ABC8FDCA2F4
            F3BB9575952D48A9019C6580466B89D63FAAED4F51B11558585CA27A75259EE7
            A2748092060B2891941168AD4213EB132930323AC1FF935FA85B5FC3F12371A4
            F6114202E009A12C512AB5E2684AC931F67C7F708CB565BBB8717690AEAB5B48
            67965853E12382B003DF170855442AC9CC4C8AFEC7236C6DD9C4EE783323AF26
            A8ADDEC7A9F66EAEF49DA03D99205659812F0A148A3E165022E5FD1CD97C9EFE
            872FE9E9FA8F47AF6ED1737D809D1B4FD2D176817BC397A9AD536C68A822574C
            53EE6411225C621048842C10C880B644923BCFBA39DF7997C9E9C3FC55BF994C
            EE33E3538374FC93643E9BB2E355951510221C41488D6F013E750D352C6632DC
            7E728ED3477BC175B874AD93FD895616B2B380C618F0450E1128003C19683B93
            54826F6A9EA6E675BC1B9FE2E9EB5E1AEB9B70631962D5057C195877005FE6A3
            7B2084A628F30825D00616E51CDB7734F27CA88FBEE14F1C3BF437393F83C158
            773025C368075228029127500227BC44F3B9AF1C4CB652597E80B9F4478A4202
            7A05501405A20EA4B11DC4BC1AB02E1A6D0CE9FC1C0BB95930066F5585FD8E01
            6DECCE501680F18A3931363CF4210E267C88344CB6D605B4E5E1601081790B48
            6FA0673A017880CBEFC309D50002F0BF03C5148A5699E7E19C0000000049454E
            44AE426082}
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 1
          Font.Charset = ANSI_CHARSET
          Font.Color = 5592405
          Font.Height = -12
          Font.Name = 'Open Sans SemiBold'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = BtSairClick
        end
      end
      object PnContent: TRzPanel
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 604
        Height = 193
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BorderOuter = fsNone
        Color = clWhite
        TabOrder = 1
      end
    end
  end
end
