unit PersonInsert.Controller;

interface

uses Person.Controller.Interf, Person.Model.Interf, TMNGPERSON.Entity.Model,
   System.SysUtils;

type
   TPersonInsertController = class(TInterfacedObject, iPersonInsertController)
   private
      FPersonModel: IPersonModel;

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

      function getPersonId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iPersonInsertController;

      function personModel(AValue: IPersonModel): iPersonInsertController;

      function companyId(AValue: string): iPersonInsertController;
      function personType(AValue: Integer): iPersonInsertController;
      function name(AValue: string): iPersonInsertController;
      function fancyName(AValue: string): iPersonInsertController;
      function CPFCNPJ(AValue: string): iPersonInsertController;
      function RGIE(AValue: string): iPersonInsertController;
      function address(AValue: string): iPersonInsertController;
      function districtId(AValue: string): iPersonInsertController;
      function phoneNumber(AValue: string): iPersonInsertController;
      function email(AValue: string): iPersonInsertController;
      function status(AValue: Integer): iPersonInsertController;
      function userId(AValue: string): iPersonInsertController;

      procedure save;
   end;

implementation

{ TPersonInsertController }

function TPersonInsertController.address(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FAddress := AValue;
end;

function TPersonInsertController.companyId(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

function TPersonInsertController.CPFCNPJ(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FCPFCNPJ := AValue;
end;

constructor TPersonInsertController.Create;
begin

end;

destructor TPersonInsertController.Destroy;
begin

   inherited;
end;

function TPersonInsertController.districtId(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FDistrictId := AValue;
end;

function TPersonInsertController.email(AValue: string): iPersonInsertController;
begin
   Result := Self;
   FEmail := AValue;
end;

function TPersonInsertController.fancyName(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FFancyName := AValue;
end;

class function TPersonInsertController.New: iPersonInsertController;
begin
   Result := Self.Create;
end;

function TPersonInsertController.getPersonId: Integer;
begin
   if FPersonModel.DAO.Find.Count <> 0 then
   begin
      Result := FPersonModel.DAO.FindWhere(Format('COMPANYID = %s',
        [QuotedStr(FCompanyId)]), 'PERSONID desc').Last.PERSONID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TPersonInsertController.name(AValue: string): iPersonInsertController;
begin
   Result := Self;
   FName := AValue;
end;

procedure TPersonInsertController.save;
begin
   FPersonModel.Entity(TTMNGPERSON.Create);

   FPersonModel.Entity.companyId := FCompanyId;
   FPersonModel.Entity.PERSONID := getPersonId;
   FPersonModel.Entity.personType := FPersonType;
   FPersonModel.Entity.name := FName;
   FPersonModel.Entity.fancyName := FFancyName;
   FPersonModel.Entity.CPFCNPJ := FCPFCNPJ;
   FPersonModel.Entity.RGIE := FRGIE;
   FPersonModel.Entity.address := FAddress;
   FPersonModel.Entity.districtId := FDistrictId;
   FPersonModel.Entity.phoneNumber := FPhoneNumber;
   FPersonModel.Entity.email := FEmail;
   FPersonModel.Entity.status := FStatus;
   FPersonModel.Entity.userId := FUserId;
   FPersonModel.Entity.CREATEDAT := Now;
   FPersonModel.Entity.UPDATEDAT := Now;

   FPersonModel.DAO.Insert(FPersonModel.Entity);
end;

function TPersonInsertController.status(AValue: Integer)
  : iPersonInsertController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TPersonInsertController.userId(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TPersonInsertController.personModel(AValue: IPersonModel)
  : iPersonInsertController;
begin
   Result := Self;
   FPersonModel := AValue;
end;

function TPersonInsertController.personType(AValue: Integer)
  : iPersonInsertController;
begin
   Result := Self;
   FPersonType := AValue;
end;

function TPersonInsertController.phoneNumber(AValue: string)
  : iPersonInsertController;
begin
   Result := Self;
   FPhoneNumber := AValue;
end;

function TPersonInsertController.RGIE(AValue: string): iPersonInsertController;
begin
   Result := Self;
   FRGIE := AValue;
end;

end.
