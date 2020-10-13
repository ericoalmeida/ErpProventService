unit BDG0001IView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, Vcl.StdCtrls, cxButtons, RzLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel, Vcl.ComCtrls;

type
  IFBDG0001IView = interface
     ['{BD809F93-8074-483C-8237-F9203561E6C2}']
     procedure Exibir;
  end;

  
  TFBDG0001IView = class(TForm, IFBDG0001IView)
    PnContainer: TRzPanel;
    PnHeader: TRzPanel;
    ImTitle: TImage;
    LbTitle: TRzLabel;
    PnProgram: TRzPanel;
    LbProgram: TRzLabel;
    PnContainerBody: TRzPanel;
    PnFooterBody: TRzPanel;
    PnButtonConfirm: TRzPanel;
    BtConfirmar: TcxButton;
    PnContent: TRzPanel;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    cxButton1: TcxButton;
    ProgressBar1: TProgressBar;
    OdChooseFile: TOpenDialog;
    Lbarquivo: TRzLabel;
    RzLabel1: TRzLabel;
    procedure cxButton1Click(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
     class function New: IFBDG0001IView;
     
     procedure Exibir;
  end;

var
  FBDG0001IView: TFBDG0001IView;

implementation

{$R *.dfm}

procedure TFBDG0001IView.BtConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TFBDG0001IView.cxButton1Click(Sender: TObject);
begin
   try
      if OdChooseFile.Execute then
      begin
         Lbarquivo.Caption := OdChooseFile.FileName;
         Lbarquivo.Visible := True;


         ProgressBar1.Min      := 0;
         ProgressBar1.Max      := 1000;
         ProgressBar1.Position := 0;
         Application.ProcessMessages;

         while ProgressBar1.Position < 1000 do
         begin
            ProgressBar1.Position := ProgressBar1.Position + 1;
            Application.ProcessMessages;
         end;

         RzLabel1.Caption := 'Importação concluída!!!';
         RzLabel1.Visible := True;
      end;

   except
      on E: Exception do
      begin
         raise Exception.Create('Arquivo inválido!!');
      end;

   end;
end;

procedure TFBDG0001IView.Exibir;
begin
 ShowModal;
end;

class function TFBDG0001IView.New: IFBDG0001IView;
begin
   Result := Self.Create(nil);
end;

end.
