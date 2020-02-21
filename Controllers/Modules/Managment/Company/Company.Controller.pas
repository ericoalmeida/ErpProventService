unit Company.Controller;

interface

uses Company.Controller.Interf, Company.Model.Interf, TMNGCOMPANY.Entity.Model,
  System.SysUtils;

type
  TCompanyController = class(TInterfacedObject, iCompanyController)
  private
    FCompanyModel: ICompanyModel;
    FRecordFound: TTMNGCOMPANY;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCompanyController;

    function find(AValue: string): iCompanyController;

    function insert: iCompanyInsertController;
    function update: iCompanyUpdateController;
    function delete: iCompanyDeleteController;
    function duplicate: iCompanyDuplicateController;

    function code: string;
    function companyId: string;
    function name: string;
    function fancyName: string;
    function cpfcnpj: string;
    function rgie: string;
    function address: string;
    function districtId: string;
    function districtName: string;
    function phoneNumber: string;
    function email: string;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TCompanyController }

uses Facade.Model, CompanyInsert.Controller, CompanyUpdate.Controller,
  CompanyDelete.Controller, CompanyDuplicate.Controller;

function TCompanyController.address: string;
begin
  Result := FRecordFound.address;
end;

function TCompanyController.code: string;
begin
  Result := FRecordFound.code;
end;

function TCompanyController.companyId: string;
begin
  Result := FRecordFound.COMPANYID.ToString;
end;

function TCompanyController.cpfcnpj: string;
begin
  Result := FRecordFound.cpfcnpj;
end;

constructor TCompanyController.Create;
begin
  FCompanyModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    companyModel;
end;

function TCompanyController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.createdAt);
end;

function TCompanyController.delete: iCompanyDeleteController;
begin
  Result := TCompanyDeleteController.New.companyModel(FCompanyModel)
    .selectedRecord(FRecordFound);
end;

destructor TCompanyController.Destroy;
begin

  inherited;
end;

function TCompanyController.districtId: string;
begin
 Result := FRecordFound.TMNGDISTRICT.DISTRICTID.ToString;
end;

function TCompanyController.districtName: string;
begin
 Result := FRecordFound.TMNGDISTRICT.DESCRIPTION;
end;

function TCompanyController.duplicate: iCompanyDuplicateController;
begin
  Result := TCompanyDuplicateController.New.companyModel(FCompanyModel);
end;

function TCompanyController.email: string;
begin
 Result := FRecordFound.EMAIL;
end;

function TCompanyController.insert: iCompanyInsertController;
begin
  Result := TCompanyInsertController.New.companyModel(FCompanyModel);
end;

function TCompanyController.name: string;
begin
  Result := FRecordFound.name;
end;

class function TCompanyController.New: iCompanyController;
begin
  Result := Self.Create;
end;

function TCompanyController.fancyName: string;
begin
  Result := FRecordFound.fancyName;
end;

function TCompanyController.phoneNumber: string;
begin
 Result := FRecordFound.PHONENUMBER;
end;

function TCompanyController.rgie: string;
begin
  Result := FRecordFound.rgie;
end;

function TCompanyController.find(AValue: string): iCompanyController;
begin
  Result := Self;

  FRecordFound := FCompanyModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TCompanyController.update: iCompanyUpdateController;
begin
  Result := TCompanyUpdateController.New.companyModel(FCompanyModel)
    .selectedRecord(FRecordFound);
end;

function TCompanyController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.updatedAt);
end;

end.
