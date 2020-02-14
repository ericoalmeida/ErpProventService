unit CountryUpdate.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TGERPAIS.Entity.Model;

type
  TCountryUpdateController = class(TInterfacedObject, iCountryUpdateController)
  private
   FCountryModel: ICountryModel;
   FSelectedRecord: TTGERPAIS;

   FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryUpdateController;

    function countryModel(AValue: ICountryModel): iCountryUpdateController;
    function selectedRecord(AValue: TTGERPAIS): iCountryUpdateController;

    function description(AValue: string): iCountryUpdateController;

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

function TCountryUpdateController.description(AValue: string): iCountryUpdateController;
begin
  Result := Self;
  FDescription := AValue;
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

  FSelectedRecord.DESCRICAO := FDescription;

  FCountryModel.DAO.Update(FSelectedRecord);
end;

function TCountryUpdateController.selectedRecord(AValue: TTGERPAIS): iCountryUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
