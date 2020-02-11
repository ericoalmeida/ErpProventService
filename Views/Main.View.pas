unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxRibbonCustomizationForm, dxBar, dxBarApplicationMenu,
  dxRibbon, cxClasses, dxStatusBar, dxRibbonStatusBar, dxGDIPlusClasses, Vcl.ExtCtrls;

type
  TFMainView = class(TForm)
    TbAdministration: TdxRibbonTab;
    RbMainMenu: TdxRibbon;
    StStatus: TdxRibbonStatusBar;
    BrManager: TdxBarManager;
    ApMainMenu: TdxBarApplicationMenu;
    ImLogo: TImage;
    BmCadastros: TdxBar;
    BtClient: TdxBarLargeButton;
    BtServices: TdxBarLargeButton;
    BtMachine: TdxBarLargeButton;
    BtCities: TdxBarLargeButton;
    BtStates: TdxBarLargeButton;
    BtCountries: TdxBarLargeButton;
    BmAtalhos: TdxBar;
    BmRotinas: TdxBar;
    BtServicesProvision: TdxBarLargeButton;
    BtCost: TdxBarLargeButton;
    BmRelatorios: TdxBar;
    BtReportServicesProvision: TdxBarLargeButton;
    BtReportCost: TdxBarLargeButton;
    TmMainMenu: TTimer;
    BtDistrict: TdxBarLargeButton;
    BtTypeCost: TdxBarLargeButton;
    BmSupervisor: TdxBar;
    TbSupervisor: TdxRibbonTab;
    BtEmpresas: TdxBarLargeButton;
    BtUsuarios: TdxBarLargeButton;
    procedure TmMainMenuTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainView: TFMainView;

implementation

{$R *.dfm}

uses Facade.View, Types.Views;

procedure TFMainView.TmMainMenuTimer(Sender: TObject);
begin
  if Self.MDIChildCount <= 0 then
    RbMainMenu.ShowTabGroups := True
  else
    RbMainMenu.ShowTabGroups := False
end;

end.
