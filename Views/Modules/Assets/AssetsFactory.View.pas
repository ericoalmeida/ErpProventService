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

uses ASS0001AView, ASS0001BView, ASS0002AView, ASS0002BView, ASS0002CView;

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

    tpASS0002AView:
      Result := TFASS0002AView.New;

  end;
end;

function TAssetsFactoryView.showProgramOfRegister(AValue: TTypeRegisterPrograms)
  : iBaseRegisterView;
begin
  case AValue of
    trASS0001BView:
      Result := TFASS0001BView.New;

    trASS0002BView:
      Result := TFASS0002BView.New;
  end;
end;

function TAssetsFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin
  case AValue of
    tsASS0002CView:
      Result := TFASS0002CView.New;
  end;
end;

end.
