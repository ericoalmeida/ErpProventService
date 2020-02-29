unit SinapiProductDelete.Controller;

interface

uses SinapiProduct.Controller.interf,
  SinapiProduct.Model.interf, Base.View.interf, TSTOSINAPIPRODUCT.Entity.Model;

type
  TSinapiProductDeleteController = class(TInterfacedObject,
    iSinapiProductDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FProductModel: iSinapiProductModel;
    FSelectedRecord: TTSTOSINAPIPRODUCT;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iSinapiProductDeleteController;

    function productModel(AValue: iSinapiProductModel)
      : iSinapiProductDeleteController;
    function selectedRecord(AValue: TTSTOSINAPIPRODUCT)
      : iSinapiProductDeleteController;

    procedure save;
  end;

implementation

{ TSinapiProductDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TSinapiProductDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TSinapiProductDeleteController.Destroy;
begin

  inherited;
end;

function TSinapiProductDeleteController.productModel
  (AValue: iSinapiProductModel): iSinapiProductDeleteController;
begin
  Result := Self;
  FProductModel := AValue;
end;

class function TSinapiProductDeleteController.New
  : iSinapiProductDeleteController;
begin
  Result := Self.Create;
end;

procedure TSinapiProductDeleteController.save;
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

function TSinapiProductDeleteController.selectedRecord(AValue: TTSTOSINAPIPRODUCT)
  : iSinapiProductDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
