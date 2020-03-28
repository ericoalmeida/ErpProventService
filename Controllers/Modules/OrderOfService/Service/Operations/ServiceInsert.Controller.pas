unit ServiceInsert.Controller;

interface

uses Service.Controller.Interf, Service.Model.Interf,
  TORDSERVICE.Entity.Model,
  System.SysUtils;

type
  TServiceInsertController = class(TInterfacedObject, iServiceInsertController)
  private
    FServiceModel: IServiceModel;
    FCompanyId: string;
    FDescription: string;
    FPaymentType: Integer;
    FPrice: Currency;
    FStatus: Integer;
    FUserId: string;

    function getServiceId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceInsertController;

    function serviceModel(AValue: IServiceModel): iServiceInsertController;

    function companyId(AValue: string): iServiceInsertController;
    function description(AValue: string): iServiceInsertController;
    function paymentType(AValue: Integer): iServiceInsertController;
    function price(AValue: Currency): iServiceInsertController;
    function status(AValue: Integer): iServiceInsertController;
    function userId(AValue: string): iServiceInsertController;

    procedure save;
  end;

implementation

{ TServiceInsertController }

function TServiceInsertController.companyId(AValue: string): iServiceInsertController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TServiceInsertController.Create;
begin

end;

function TServiceInsertController.description(AValue: string): iServiceInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TServiceInsertController.Destroy;
begin

  inherited;
end;

class function TServiceInsertController.New: iServiceInsertController;
begin
  Result := Self.Create;
end;

function TServiceInsertController.price(AValue: Currency): iServiceInsertController;
begin
  Result := Self;
  FPrice := AValue;
end;

function TServiceInsertController.getServiceId: Integer;
begin
  if FServiceModel.DAO.Find.Count <> 0 then
  begin
    Result := FServiceModel.DAO.FindWhere(Format('COMPANYID = %s',
      [QuotedStr(FCompanyId)]), 'SERVICEID desc').Last.SERVICEID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

function TServiceInsertController.paymentType(AValue: Integer): iServiceInsertController;
begin
  Result := Self;
  FPaymentType := AValue;
end;

procedure TServiceInsertController.save;
begin
  FServiceModel.Entity(TTORDSERVICE.Create);

  FServiceModel.Entity.COMPANYID    := FCompanyId;
  FServiceModel.Entity.SERVICEID    := getServiceId;
  FServiceModel.Entity.DESCRIPTION  := FDescription;
  FServiceModel.Entity.PAYMENTTYPE  := FPaymentType;
  FServiceModel.Entity.PRICE        := FPrice;
  FServiceModel.Entity.STATUS       := FStatus;
  FServiceModel.Entity.USERID       := FUserId;
  FServiceModel.Entity.CREATEDAT    := Now;
  FServiceModel.Entity.UPDATEDAT    := Now;

  FServiceModel.DAO.Insert(FServiceModel.Entity);
end;

function TServiceInsertController.serviceModel(AValue: IServiceModel)
  : iServiceInsertController;
begin
  Result := Self;
  FServiceModel := AValue;
end;

function TServiceInsertController.status(AValue: Integer): iServiceInsertController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TServiceInsertController.userId(AValue: string): iServiceInsertController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
