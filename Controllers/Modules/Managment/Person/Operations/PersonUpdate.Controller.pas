unit PersonUpdate.Controller;

interface

uses Person.Controller.Interf, Person.Model.Interf,
  System.SysUtils, TMNGPERSON.Entity.Model;

type
  TPersonUpdateController = class(TInterfacedObject,
    iPersonUpdateController)
  private
    FPersonModel: IPersonModel;
    FSelectedRecord: TTMNGPERSON;

    FCompanyId: string;
    FPersonType: Integer;
    FName: string;
    FFancyName: string;
    FCPFCNPJ: string;
    FRGIE: string;
    FAddress: string;
    FDistrictId: string;
    FPhoneNumber: string;
    FEmail: string;
    FStatus: Integer;
    FUserId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iPersonUpdateController;

    function personModel(AValue: IPersonModel): iPersonUpdateController;
    function selectedRecord(AValue: TTMNGPERSON): iPersonUpdateController;

    function companyId(AValue: string): iPersonUpdateController;
    function personType(AValue: Integer): iPersonUpdateController;
    function name(AValue: string): iPersonUpdateController;
    function fancyName(AValue: string): iPersonUpdateController;
    function CPFCNPJ(AValue: string): iPersonUpdateController;
    function RGIE(AValue: string): iPersonUpdateController;
    function address(AValue: string): iPersonUpdateController;
    function districtId(AValue: string): iPersonUpdateController;
    function phoneNumber(AValue: string): iPersonUpdateController;
    function email(AValue: string): iPersonUpdateController;
    function status(AValue: Integer): iPersonUpdateController;
    function userId(AValue: string): iPersonUpdateController;

    procedure save;
  end;

implementation

{ TPersonUpdateController }

function TPersonUpdateController.personModel(AValue: IPersonModel)
  : iPersonUpdateController;
begin
  Result := Self;
  FPersonModel := AValue;
end;

function TPersonUpdateController.address(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FAddress := AValue;
end;

function TPersonUpdateController.companyId(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

function TPersonUpdateController.CPFCNPJ(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FCPFCNPJ := AValue;
end;

function TPersonUpdateController.personType(AValue: Integer): iPersonUpdateController;
begin
  Result := Self;
  FPersonType := AValue;
end;

function TPersonUpdateController.phoneNumber(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FPhoneNumber := AValue;
end;

function TPersonUpdateController.RGIE(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FRGIE := AValue;
end;

constructor TPersonUpdateController.Create;
begin

end;

destructor TPersonUpdateController.Destroy;
begin

  inherited;
end;

function TPersonUpdateController.districtId(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FDistrictId := AValue;
end;

function TPersonUpdateController.email(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FEmail := AValue;
end;

function TPersonUpdateController.fancyName(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FFancyName := AValue;
end;

function TPersonUpdateController.name(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FName := AValue;
end;

class function TPersonUpdateController.New: iPersonUpdateController;
begin
  Result := Self.Create;
end;

procedure TPersonUpdateController.save;
begin
  FPersonModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.COMPANYID   := FCompanyId;
  FSelectedRecord.PERSONTYPE  := FPersonType;
  FSelectedRecord.NAME        := FName;
  FSelectedRecord.FANCYNAME   := FFancyName;
  FSelectedRecord.CPFCNPJ     := FCPFCNPJ;
  FSelectedRecord.RGIE        := FRGIE;
  FSelectedRecord.ADDRESS     := FAddress;
  FSelectedRecord.DISTRICTID  := FDistrictId;
  FSelectedRecord.PHONENUMBER := FPhoneNumber;
  FSelectedRecord.EMAIL       := FEmail;
  FSelectedRecord.STATUS      := FStatus;
  FSelectedRecord.USERID      := FUserId;
  FSelectedRecord.UPDATEDAT   := Now;

  FPersonModel.DAO.Update(FSelectedRecord);
end;

function TPersonUpdateController.selectedRecord(AValue: TTMNGPERSON)
  : iPersonUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TPersonUpdateController.status(AValue: Integer): iPersonUpdateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TPersonUpdateController.userId(AValue: string): iPersonUpdateController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
