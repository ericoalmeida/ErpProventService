unit DistrictDelete.Controller;

interface

uses District.Controller.Interf, TMNGDISTRICT.Entity.Model,
  Districts.Model.Interf, Base.View.Interf;

type
  TDistrictDeleteController = class(TInterfacedObject,
    iDistrictDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FDistrictModel: iDistrictModel;
    FSelectedRecord: TTMNGDISTRICT;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictDeleteController;

    function districtModel(AValue: iDistrictModel): iDistrictDeleteController;
    function selectedDistrict(AValue: TTMNGDISTRICT): iDistrictDeleteController;

    procedure save;
  end;

implementation

{ TDistrictDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TDistrictDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TDistrictDeleteController.Destroy;
begin

  inherited;
end;

function TDistrictDeleteController.districtModel(AValue: iDistrictModel)
  : iDistrictDeleteController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

class function TDistrictDeleteController.New: iDistrictDeleteController;
begin
  Result := Self.Create;
end;

procedure TDistrictDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o bairro %s ?',
    [FSelectedRecord.DESCRIPTION])).&end then
  begin

    try
      FDistrictModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O Bairro %s não pode ser excluído!',
          [FSelectedRecord.DESCRIPTION]));
    end;

  end;
end;

function TDistrictDeleteController.selectedDistrict(AValue: TTMNGDISTRICT)
  : iDistrictDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
