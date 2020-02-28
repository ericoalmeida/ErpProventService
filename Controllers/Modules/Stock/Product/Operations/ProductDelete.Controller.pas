unit ProductDelete.Controller;

interface

uses Product.Controller.interf,
  Product.Model.interf, Base.View.interf, TSTOPRODUCT.Entity.Model;

type
  TProductDeleteController = class(TInterfacedObject,
    iProductDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FProductModel: IProductModel;
    FSelectedRecord: TTSTOPRODUCT;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iProductDeleteController;

    function productModel(AValue: IProductModel): iProductDeleteController;
    function selectedRecord(AValue: TTSTOPRODUCT)
      : iProductDeleteController;

    procedure save;
  end;

implementation

{ TProductDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TProductDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TProductDeleteController.Destroy;
begin

  inherited;
end;

function TProductDeleteController.productModel(AValue: IProductModel)
  : iProductDeleteController;
begin
  Result := Self;
  FProductModel := AValue;
end;

class function TProductDeleteController.New: iProductDeleteController;
begin
  Result := Self.Create;
end;

procedure TProductDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o produto %s ?',
    [FSelectedRecord.DESCRIPTION])).&end then
  begin

    try
      FProductModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O Produto %s não pode ser excluído!',
          [FSelectedRecord.DESCRIPTION]));
    end;

  end;
end;

function TProductDeleteController.selectedRecord(AValue: TTSTOPRODUCT)
  : iProductDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
