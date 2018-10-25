unit untCancelaInseminacao;       //Versao 1.5.0 - 25/10/2018 - RS

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCancelaInseminacao = class(TForm)
    pnlPrincipal: TPanel;
    pnlRodape: TPanel;
    lblConfirmadas: TLabel;
    btnFechar: TBitBtn;
    grpTop: TGroupBox;
    edtCodProprietario: TEdit;
    lblProdutor: TLabel;
    btnPesquProprietario: TBitBtn;
    edtProprietario: TEdit;
    dbgInseminacoes: TDBGrid;
    btnPesquisar: TBitBtn;
    qryInseminacoes: TFDQuery;
    dtsInseminacoes: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioChange(Sender: TObject);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbgInseminacoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaGrid;
  public
    { Public declarations }
  end;

var
  frmCancelaInseminacao: TfrmCancelaInseminacao;

implementation

{$R *.dfm}

uses untFuncoes;

procedure TfrmCancelaInseminacao.btnPesquisarClick(Sender: TObject);
begin
  CarregaGrid;
end;

procedure TfrmCancelaInseminacao.CarregaGrid;
begin
  qryInseminacoes.Close;
  qryInseminacoes.SQL.Clear;
  qryInseminacoes.SQL.Add(frmFuncoes.LerArquivoIni('INSEMINACAO', 'CANCELAR'));
  qryInseminacoes.ParamByName('STATUS').AsString := 'S';
  qryInseminacoes.ParamByName('ID_PRODUTOR').AsString := edtCodProprietario.Text;
  qryInseminacoes.Open;
end;

procedure TfrmCancelaInseminacao.dbgInseminacoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    if Application.MessageBox('Deseja realmente cancelar a Inseminação?', 'Curral Novo', MB_YESNO) = mrYes then
    begin

    end;
  end;
end;

procedure TfrmCancelaInseminacao.edtCodProprietarioChange(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) = '' then
    edtProprietario.Clear;
end;

procedure TfrmCancelaInseminacao.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCancelaInseminacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCancelaInseminacao.FormShow(Sender: TObject);
begin
  edtCodProprietario.Clear;
  edtProprietario.Clear;
  qryInseminacoes.Close;
end;

end.
