unit Country.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TGERPAIS.Entity.Model,
  System.SysUtils;

type
  TCountryController = class(TInterfacedObject, iCountryController)
  private
    FCountryModel: ICountryModel;
    FRecordFound: TTGERPAIS;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryController;

    function find(AValue: string): iCountryController;

    function insert: iCountryInsertController;
    function update: iCountryUpdateController;
    function delete: iCountryDeleteController;
    function duplicate: iCountryDuplicateController;

    function countryId: string;
    function description: string;
    function createdDate: string;
    function updatedDate: string;
  end;

implementation

{ TCountryController }

uses Facade.Model, CountryInsert.Controller;

constructor TCountryController.Create;
begin
  FCountryModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    countryModel;
end;

function TCountryController.createdDate: string;
begin
  Result := DateTimeToStr(FRecordFound.DATACADASTRO);
end;

function TCountryController.delete: iCountryDeleteController;
begin

end;

function TCountryController.description: string;
begin
  Result := FRecordFound.DESCRICAO;
end;

destructor TCountryController.Destroy;
begin

  inherited;
end;

function TCountryController.duplicate: iCountryDuplicateController;
begin

end;

function TCountryController.insert: iCountryInsertController;
begin
  Result := TCountryInsertController.New.countryModel(FCountryModel);
end;

class function TCountryController.New: iCountryController;
begin
  Result := Self.Create;
end;

function TCountryController.countryId: string;
begin
  Result := FRecordFound.PAISID.ToString;
end;

function TCountryController.find(AValue: string): iCountryController;
begin
  Result := Self;

  FRecordFound := FCountryModel.DAO.FindWhere
    (Format('CODIGO = %s', [QuotedStr(AValue)])).Items[0];
end;

function TCountryController.update: iCountryUpdateController;
begin

end;

function TCountryController.updatedDate: string;
begin
  Result := DateTimeToStr(FRecordFound.DATAATUALIZACAO);
end;

end.
