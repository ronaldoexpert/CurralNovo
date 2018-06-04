unit untRelatorioGraficos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, IniFiles,Registry, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase,
  DateUtils, Vcl.Imaging.pngimage, Vcl.Mask;

type
  TfrmRelGraficos = class(TForm)
    pnlPrincipal: TPanel;
    GroupBox1: TGroupBox;
    edtDtInicio: TDateTimePicker;
    Label1: TLabel;
    edtDtFim: TDateTimePicker;
    Label2: TLabel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelGraficos: TfrmRelGraficos;

implementation

{$R *.dfm}

procedure TfrmRelGraficos.btnFecharClick(Sender: TObject);
begin
  frmRelGraficos.Close;
end;

procedure TfrmRelGraficos.FormActivate(Sender: TObject);
begin
  edtDtInicio.Date := StartOfTheMonth(Date);
  edtDtFim.Date := EndOfTheMonth(Date);
end;

end.
