unit untPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPesquisa = class(TForm)
    dbgPesquisa: TDBGrid;
    qryPesquisa: TFDQuery;
    dtsPesquisa: TDataSource;
    pnlPesquisa: TPanel;
    btnFechar: TBitBtn;
    GroupBox1: TGroupBox;
    lblCampoPesquisa: TLabel;
    edtPesquisa: TEdit;
    procedure FormShow(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
    procedure dbgPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPesquisaTitleClick(Column: TColumn);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Selecionar;
  public
    { Public declarations }
    vTabela, vTela, vComando : String;

  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

uses unstCadastroVeterinario, untCadastroAnimal, untCadastroCria,
  untCadastroProduto, untCadastroProdutor, untCadastroServico,
  untCadastroTipoProdutor, untCadastroUsuario, untDM, untFuncoes, untLogin,
  untPrincipal, untConfirmaInseminacao, untInseminacao;

{ TfrmPesquisa }

procedure TfrmPesquisa.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPesquisa.dbgPesquisaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TfrmPesquisa.dbgPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgPesquisa.Canvas.Brush.Color := clNavy;
    dbgPesquisa.Canvas.Font.Color := clWhite;
  end;

  dbgPesquisa.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmPesquisa.dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPesquisa.dbgPesquisaTitleClick(Column: TColumn);
begin
  lblCampoPesquisa.Caption := Column.Title.Caption;
  edtPesquisa.Clear;
  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.edtPesquisaChange(Sender: TObject);
begin
  if edtPesquisa.Text <> '' then
  begin
    qryPesquisa.IndexFieldNames := lblCampoPesquisa.Caption;
    qryPesquisa.SetKey;
    qryPesquisa.FieldByName(lblCampoPesquisa.Caption).AsString := edtPesquisa.Text;
    qryPesquisa.GotoNearest;
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

procedure TfrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 38 then
  begin
    // seta para cima, volta um registro
    qryPesquisa.Prior;
  end
  else if key = 40 then
  begin
    // seta para baixo, avança um registro
    qryPesquisa.Next;
  end;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  frmFuncoes.ExecutaSQL(vComando, 'Abrir', qryPesquisa);
  dbgPesquisa.DataSource := dtsPesquisa;

  if (vTabela = 'ANIMAL') OR (vTabela = 'CRIA') OR (vTabela = 'PRODUTOR') OR (vTabela = 'VETERINARIO') OR (vTabela = 'USUARIO') then
  BEGIN
    lblCampoPesquisa.Caption := 'NOME';
  END
  ELSE if (vTabela = 'SERVICO') OR (vTabela = 'PRODUTO') then
  BEGIN
    lblCampoPesquisa.Caption := 'DESCRICAO';
  END;

  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.Selecionar;
begin
  if vTabela = 'USUARIO' then
  begin
    if vTela = 'CAD_USUARIO' then
    BEGIN
      frmCadastroUsuario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroUsuario.PesquisaUsuario(True);
    END;
  end
  else if vTabela = 'ANIMAL' then
  begin
    if vTela = 'CAD_ANIMAL' then
    BEGIN
      frmCadastroAnimal.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaAnimal(True);
    END;
  end
  ELSE
  if vTabela = 'PRODUTOR' then
  begin
    if vTela = 'CAD_ANIMAL' then
    BEGIN
      frmCadastroAnimal.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaProprietario(True);
    END
    else if vTela = 'CAD_CRIA' then
    BEGIN
      frmCadastroCria.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaProprietario(True);
    END
    else if vTela = 'CADASTRO' then
    BEGIN
      frmCadastroVeterinario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroVeterinario.PesquisaBD(True);
    END
    else if vTela = 'CONFIRMA_INS' then
    BEGIN
      frmConfirmaInseminacao.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmConfirmaInseminacao.PesquisaProdutor(True);
    END;
  end
  else if vTabela = 'CRIA' then
  begin
    if vTela = 'CAD_CRIA' then
    BEGIN
      frmCadastroCria.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaAnimal(True);
    END;
  end
  else if vTabela = 'VETERINARIO' then
  begin
    if vTela = 'CADASTRO' then
    BEGIN
      frmCadastroVeterinario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroVeterinario.PesquisaBD(True);
    END
    else if vTela = 'CONFIRMA_INS' then
    BEGIN
      frmConfirmaInseminacao.edtCodVeterinario.Text := dbgPesquisa.Fields[0].Value;
      frmConfirmaInseminacao.PesquisaVeterinario(True);
    END;

  end;


  Close;
end;

end.
