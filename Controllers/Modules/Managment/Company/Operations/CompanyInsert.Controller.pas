unit CompanyInsert.Controller;

interface

uses Company.Controller.Interf, Company.Model.Interf, TMNGCOMPANY.Entity.Model, System.SysUtils;

type
  TCompanyInsertController = class(TInterfacedObject, iCompanyInsertController)
  private
    FCompanyModel: ICompanyModel;

    FName: string;
    FFancyName: string;
    FCPFCNPJ: string;
    FRGIE: string;
    FAddress: string;
    FDistrictId: string;
    FPhoneNumber: string;
    FEmail: string;

    function getCompanyId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCompanyInsertController;

    function companyModel(AValue: ICompanyModel): iCompanyInsertController;

    function name(AValue: string): iCompanyInsertController;
    function fancyName(AValue: string): iCompanyInsertController;
    function cpfcnpj(AValue: string): iCompanyInsertController;
    function rgie(AValue: string): iCompanyInsertController;
    function address(AValue: string): iCompanyInsertController;
    function districtId(AValue: string): iCompanyInsertController;
    function phoneNumber(AValue: string): iCompanyInsertController;
    function email(AValue: string): iCompanyInsertController;

    procedure save;
  end;

implementation

{ TCompanyInsertController }

function TCompanyInsertController.cpfcnpj(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FCPFCNPJ := AValue;
end;

constructor TCompanyInsertController.Create;
begin

end;

destructor TCompanyInsertController.Destroy;
begin

  inherited;
end;

function TCompanyInsertController.districtId(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FDistrictId := AValue;
end;

function TCompanyInsertController.email(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FEmail := AValue;
end;

function TCompanyInsertController.fancyName(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FFancyName := AValue;
end;

function TCompanyInsertController.getCompanyId: Integer;
begin
  if FCompanyModel.DAO.Find.Count <> 0 then  begin
    Result := FCompanyModel.DAO.FindWhere('', 'COMPANYID desc').Last.COMPANYID + 1;
  end else begin
    Result := 1;
  end;
end;

function TCompanyInsertController.name(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FName := AValue;
end;

class function TCompanyInsertController.New: iCompanyInsertController;
begin
  Result := Self.Create;
end;

function TCompanyInsertController.phoneNumber(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FPhoneNumber := AValue;
end;

function TCompanyInsertController.rgie(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FRGIE := AValue;
end;

procedure TCompanyInsertController.save;
begin
  FCompanyModel.Entity(TTMNGCOMPANY.Create);

  FCompanyModel.Entity.COMPANYID   := getCompanyId;
  FCompanyModel.Entity.NAME        := FName;
  FCompanyModel.Entity.FANCYNAME   := FFancyName;
  FCompanyModel.Entity.CPFCNPJ     := FCPFCNPJ;
  FCompanyModel.Entity.RGIE        := FRGIE;
  FCompanyModel.Entity.ADDRESS     := FAddress;
  FCompanyModel.Entity.DISTRICTID  := FDistrictId;
  FCompanyModel.Entity.PHONENUMBER := FPhoneNumber;
  FCompanyModel.Entity.EMAIL       := FEmail;
  FCompanyModel.Entity.CREATEDAT   := Now;
  FCompanyModel.Entity.UPDATEDAT   := Now;

  FCompanyModel.DAO.Insert(FCompanyModel.Entity);
end;

function TCompanyInsertController.address(AValue: string): iCompanyInsertController;
begin
  Result := Self;
  FAddress := AValue;
end;

function TCompanyInsertController.companyModel(AValue: ICompanyModel)
  : iCompanyInsertController;
begin
  Result := Self;
  FCompanyModel := AValue;
end;

end.
