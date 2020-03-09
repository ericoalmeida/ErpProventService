unit Person.Controller;

interface

uses Person.Controller.Interf, Person.Model.Interf, TMNGPERSON.Entity.Model,
  System.SysUtils;

type
  TPersonController = class(TInterfacedObject, iPersonController)
  private
    FPersonModel: IPersonModel;
    FRecordFound: TTMNGPERSON;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iPersonController;

    function find(AValue: string): iPersonController;

    function insert: iPersonInsertController;
    function update: iPersonUpdateController;
    function delete: iPersonDeleteController;
    function duplicate: iPersonDuplicateController;

    function code: string;
    function personId: string;
    function name: string;
    function fancyName: string;
    function cpfcnpj: string;
    function rgie: string;
    function address: string;
    function districtId: string;
    function districtName: string;
    function phoneNumber: string;
    function email: string;
    function status: integer;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TPersonController }

uses Facade.Model, PersonInsert.Controller, PersonUpdate.Controller,
  PersonDelete.Controller, PersonDuplicate.Controller;

function TPersonController.address: string;
begin
 Result := FRecordFound.ADDRESS;
end;

function TPersonController.code: string;
begin
  Result := FRecordFound.CODE;
end;

function TPersonController.personId: string;
begin
  Result := FRecordFound.PERSONID.ToString;
end;

function TPersonController.cpfcnpj: string;
begin
 Result := FRecordFound.CPFCNPJ;
end;

function TPersonController.phoneNumber: string;
begin
 Result := FRecordFound.PHONENUMBER;
end;

function TPersonController.rgie: string;
begin
 Result := FRecordFound.RGIE;
end;

function TPersonController.status: integer;
begin
  Result := FRecordFound.STATUS;
end;

constructor TPersonController.Create;
begin
  FPersonModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    personModel;
end;

function TPersonController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.CREATEDAT);
end;

function TPersonController.delete: iPersonDeleteController;
begin
  Result := TPersonDeleteController.New.personModel(FPersonModel)
    .selectedRecord(FRecordFound);
end;

destructor TPersonController.Destroy;
begin

  inherited;
end;

function TPersonController.districtId: string;
begin
 Result := FRecordFound.TMNGDISTRICT.DISTRICTID.ToString;
end;

function TPersonController.districtName: string;
begin
 Result := FRecordFound.TMNGDISTRICT.DESCRIPTION;
end;

function TPersonController.duplicate: iPersonDuplicateController;
begin
  Result := TPersonDuplicateController.New.personModel(FPersonModel);
end;

function TPersonController.email: string;
begin
 Result := FRecordFound.EMAIL;
end;

function TPersonController.insert: iPersonInsertController;
begin
  Result := TPersonInsertController.New.personModel(FPersonModel);
end;

function TPersonController.name: string;
begin
 Result := FRecordFound.NAME;
end;

class function TPersonController.New: iPersonController;
begin
  Result := Self.Create;
end;

function TPersonController.fancyName: string;
begin
 Result := FRecordFound.FANCYNAME;
end;

function TPersonController.find(AValue: string): iPersonController;
begin
  Result := Self;

  FRecordFound := FPersonModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TPersonController.update: iPersonUpdateController;
begin
  Result := TPersonUpdateController.New.personModel(FPersonModel)
    .selectedRecord(FRecordFound);
end;

function TPersonController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.UPDATEDAT);
end;

end.
