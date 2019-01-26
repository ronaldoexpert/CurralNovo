unit untPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, FMTBcd, DB,
  DBClient, Provider, SqlExpr;

type
  TfrmPesquisa = class(TForm)
    pnlPesquisa: TPanel;
    btnFechar: TBitBtn;
    grp1: TGroupBox;
    lblCampoPesquisa: TLabel;
    edtPesquisa: TEdit;
    dbgrdPesquisa: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgrdPesquisaDblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbgrdPesquisaTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    vTabela, vComando, vTela : String;
    procedure Selecionar;
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

uses untRelInseminacao, untDM, untRelProprietarios, untRelAnimais;

{$R *.dfm}

procedure TfrmPesquisa.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPesquisa.Selecionar;
begin
  if vTabela = 'PRODUTOR' then
  BEGIN
    if vTela = 'REL_INSEMINACAO' then
    BEGIN
      frmRelInseminacoes.edtCodigo.Text := dbgrdPesquisa.Fields[0].Value;
      frmRelInseminacoes.PesquisaProprietario(True);
    end
    else
    if vTela = 'REL_PROPRIETARIOS' then
    BEGIN
      frmRelProprietario.edtCodigo.Text := dbgrdPesquisa.Fields[0].Value;
      frmRelProprietario.PesquisaProprietario(True);
    end;
  end
  else
  if vTabela = 'VETERINARIO' then
  BEGIN
    if vTela = 'REL_INSEMINACAO' then
    BEGIN
      frmRelInseminacoes.edtCodigo.Text := dbgrdPesquisa.Fields[0].Value;
      frmRelInseminacoes.PesquisaVeterinario(True);
    end;
  end
  else
  if vTabela = 'ANIMAL' then
  BEGIN
    if vTela = 'REL_ANIMAL' then
    BEGIN
      frmRelAnimais.edtCodigo.Text := dbgrdPesquisa.Fields[0].Value;
      frmRelAnimais.edtProprietario.Text := dbgrdPesquisa.Fields[3].Value;
      frmRelAnimais.PesquisaAnimais(True);
    end;
  end;
  close;
end;

procedure TfrmPesquisa.FormActivate(Sender: TObject);
begin
  DM.clntdtstPesquisa.Close;
  DM.sqldtstPesquisa.CommandText := vComando;
  DM.clntdtstPesquisa.open;

  IF vTabela = 'ANIMAL' then
  begin
    dbgrdPesquisa.Columns[1].Width := 150;
    dbgrdPesquisa.Columns[3].Width := 190;
  end;
end;

procedure TfrmPesquisa.dbgrdPesquisaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TfrmPesquisa.edtPesquisaChange(Sender: TObject);
begin
  if edtPesquisa.Text <> '' then
  begin
    dm.clntdtstPesquisa.IndexFieldNames := lblCampoPesquisa.Caption;
    dm.clntdtstPesquisa.SetKey;
    dm.clntdtstPesquisa.FieldByName(lblCampoPesquisa.Caption).AsString := edtPesquisa.Text;
    dm.clntdtstPesquisa.GotoNearest;
  end;
end;

procedure TfrmPesquisa.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 38 then
  begin
    // seta para cima, volta um registro
    dm.clntdtstPesquisa.Prior;
  end
  else if key = 40 then
  begin
    // seta para baixo, avança um registro
    dm.clntdtstPesquisa.Next;
  end;
end;

procedure TfrmPesquisa.edtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    // pressionado enter
    Selecionar;
  end
  else if key = #27 then
  begin
    // pressionado ESC
    close;
  end;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.dbgrdPesquisaTitleClick(Column: TColumn);
begin
  lblCampoPesquisa.Caption := Column.Title.Caption;
  edtPesquisa.Clear;
  edtPesquisa.SetFocus;
end;

end.
