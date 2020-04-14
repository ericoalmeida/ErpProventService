unit BaseRegister.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.View, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  Vcl.StdCtrls, cxButtons, RzLabel, dxGDIPlusClasses, Vcl.ExtCtrls, RzPanel,
  Types.Controllers, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Silver, System.Actions, Vcl.ActnList, dxSkinDarkRoom, dxSkinDarkSide, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxTextEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxMemo, ERGMemoEdit, cxButtonEdit, ERGButtonEdit,
  cxCalendar, ERGDateEdit, ERGNumberEdit, ERGTextEdit, Base.View.interf;

type
  TFBaseRegisterView = class(TFBaseView)
    PnContent: TRzPanel;
    LbObs: TRzLabel;
    LbOperation: TRzLabel;
    AcSearchRecord: TActionList;
    PnButtonConfirm: TRzPanel;
    BtConfirmar: TcxButton;
  private
    { Private declarations }
   protected
 
    FRequiredFields: TStringList;
    FOperation: TTypeOperation;
    FSelectedRecord: string;

    procedure changeDataAnyFields;

    procedure showCurrentOperation; virtual;

    function validate: Boolean;
  public
    { Public declarations }
  end;

var
  FBaseRegisterView: TFBaseRegisterView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;
{ TFBaseRegisterView }

procedure TFBaseRegisterView.changeDataAnyFields;
begin
  BtConfirmar.Enabled := True;
end;

procedure TFBaseRegisterView.showCurrentOperation;
begin
  case FOperation of
    toInsert:
      begin
        LbOperation.Caption := '(Incluindo)';
      end;

    toUpdate:
      begin
        LbOperation.Caption := '(Alterando)';
      end;

    toShow:
      begin
        LbOperation.Caption := '(Consultando)';
      end;

    toDelete:
      begin
        LbOperation.Caption := '(Excluindo)';
        LbOperation.Font.Color := $000000D0;
      end;

    toDuplicate:
      begin
        LbOperation.Caption := '(Duplicando)';
      end;

  end;
end;

function TFBaseRegisterView.validate: Boolean;
var
  I: Integer;
begin
  Result := True;

  FRequiredFields := TStringList.Create;

  try
 
    for I := 0 to Pred(Self.ComponentCount) do
    begin
      if Self.Components[I] is TERGTextEdit then
        if TERGTextEdit(Self.Components[I]).Enabled then
          if TERGTextEdit(Self.Components[I]).Required then
            if TERGTextEdit(Self.Components[I]).IsEmpty then
            begin
              Result := False;

              FRequiredFields.Add(TERGTextEdit(Self.Components[I]).FieldName);
            end;

      if Self.Components[I] is TERGDateEdit then
        if TERGDateEdit(Self.Components[I]).Enabled then
          if TERGDateEdit(Self.Components[I]).Required then
            if TERGDateEdit(Self.Components[I]).IsEmpty then
            begin
              Result := False;

              FRequiredFields.Add(TERGDateEdit(Self.Components[I]).FieldName);
            end;

      if Self.Components[I] is TERGButtonEdit then
        if TERGButtonEdit(Self.Components[I]).Enabled then
          if TERGButtonEdit(Self.Components[I]).Required then
            if TERGButtonEdit(Self.Components[I]).IsEmpty then
            begin
              Result := False;

              FRequiredFields.Add(TERGButtonEdit(Self.Components[I]).FieldName);
            end;

      if Self.Components[I] is TERGMemo then
        if TERGMemo(Self.Components[I]).Enabled then
          if TERGMemo(Self.Components[I]).Required then
            if TERGMemo(Self.Components[I]).IsEmpty then
            begin
              Result := False;

              FRequiredFields.Add(TERGMemo(Self.Components[I]).FieldName);
            end;

    end;

    if not(Result) then
    begin

     TFacadeView.New
      .messagesFactoryView
      .typeMessage(tmRequired)
      .Messages(FRequiredFields.Text)
      .&end;

    end;

  finally
     FRequiredFields.Free;
  end;

end;

end.
