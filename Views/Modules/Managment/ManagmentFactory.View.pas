unit ManagmentFactory.View;

interface

uses ManagmentFactory.View.Interf, Base.View.Interf, Types.Views;

type
  TManagmentFactoryView = class(TInterfacedObject, iManagmentFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iManagmentFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTYpeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;

  end;

implementation

{ TManagmentFactoryView }

uses MNG0001AView, MNG0001BView, MNG0002AView, MNG0002BView, MNG0003AView,
  MNG0003BView, MNG0002CView;

constructor TManagmentFactoryView.Create;
begin

end;

destructor TManagmentFactoryView.Destroy;
begin

  inherited;
end;

class function TManagmentFactoryView.New: iManagmentFactoryView;
begin
  Result := Self.Create;
end;

function TManagmentFactoryView.showProgramOfListing
  (AValue: TTypeListingPrograms): iBaseListView;
begin
  case AValue of
    tpMNG0001AView:
      Result := TFMNG0001AView.New;

    tpMNG0002AView:
      Result := TFMNG0002AView.New;

    tpMNG0003AView:
      Result := TFMNG0003AView.New;
  end;
end;

function TManagmentFactoryView.showProgramOfRegister
  (AValue: TTYpeRegisterPrograms): iBaseRegisterView;
begin
  case AValue of
    trMNG0001BView:
      Result := TFMNG0001BView.New;

    trMNG0002BView:
      Result := TFMNG0002BView.New;

    trMNG0003BView:
      Result := TFMNG0003BView.New;
  end;
end;

function TManagmentFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin
  case AValue of
    tsMNG0002CView:
      Result := TFMNG0002CView.New;

  end;
end;

end.
