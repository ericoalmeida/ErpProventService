unit AssetsFactory.View;

interface

uses AssetsFactory.View.Interf, Base.View.Interf, Types.Views;

type
  TAssetsFactoryView = class(TInterfacedObject, iAssetsFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iAssetsFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;
  end;

implementation

{ TAssetsFactoryView }

uses ASS0001AView, ASS0001BView;

constructor TAssetsFactoryView.Create;
begin

end;

destructor TAssetsFactoryView.Destroy;
begin

  inherited;
end;

class function TAssetsFactoryView.New: iAssetsFactoryView;
begin
  Result := Self.Create;
end;

function TAssetsFactoryView.showProgramOfListing(AValue: TTypeListingPrograms)
  : iBaseListView;
begin
  case AValue of
    tpASS0001AView:
      Result := TFASS0001AView.New;
  end;
end;

function TAssetsFactoryView.showProgramOfRegister(AValue: TTypeRegisterPrograms)
  : iBaseRegisterView;
begin
  case AValue of
    trASS0001BView:
      Result := TFASS0001BView.New;
  end;
end;

function TAssetsFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin

end;

end.
