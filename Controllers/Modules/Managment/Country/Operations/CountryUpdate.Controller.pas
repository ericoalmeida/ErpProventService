unit CountryUpdate.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TMNGCOUNTRY.Entity.Model, System.SysUtils;

type
  TCountryUpdateController = class(TInterfacedObject, iCountryUpdateController)
  private
   FCountryModel: ICountryModel;
   FSelectedRecord: TTMNGCOUNTRY;

   FName: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryUpdateController;

    function countryModel(AValue: ICountryModel): iCountryUpdateController;
    function selectedRecord(AValue: TTMNGCOUNTRY): iCountryUpdateController;

    function name(AValue: string): iCountryUpdateController;

    procedure save;
  end;

implementation

{ TCountryUpdateController }

function TCountryUpdateController.countryModel(AValue: ICountryModel): iCountryUpdateController;
begin
  Result := Self;
  FCountryModel := AValue;
end;

constructor TCountryUpdateController.Create;
begin

end;

function TCountryUpdateController.name(AValue: string): iCountryUpdateController;
begin
  Result := Self;
  FName := AValue;
end;

destructor TCountryUpdateController.Destroy;
begin

  inherited;
end;

class function TCountryUpdateController.New: iCountryUpdateController;
begin
  Result := Self.Create;
end;

procedure TCountryUpdateController.save;
begin
  FCountryModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.NAME      := FName;
  FSelectedRecord.UPDATEDAT := Now;

  FCountryModel.DAO.Update(FSelectedRecord);
end;

function TCountryUpdateController.selectedRecord(AValue: TTMNGCOUNTRY): iCountryUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
