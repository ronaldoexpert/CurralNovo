unit untMovimentaEstoqueProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMovimentaEstoqueProduto = class(TForm)
    edtCodProduto: TEdit;
    lblProduto: TLabel;
    edtDescrProduto: TEdit;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    dbgDados: TDBGrid;
    Panel1: TPanel;
    btnPesqProduto: TBitBtn;
    edtData: TMaskEdit;
    lblData: TLabel;
    edtQtd: TEdit;
    lblQuantidade: TLabel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    dtsGrid: TDataSource;
    qryGrid: TFDQuery;
    edtNumero: TEdit;
    lblNumero: TLabel;
    Edit1: TEdit;
    edtUnidade: TEdit;
    lblUnidade: TLabel;
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodAnimalKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesqProdutoClick(Sender: TObject);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    vEdita, fNovo : Boolean;               //Versao 1.1.0 - 25/05/2018
    function ValidaAnimal : Boolean;
  public
    { Public declarations }
    vTipoMovimento : String;      //Versao 1.6.1 - 20/11/2018
    procedure LimpaCampos;
    procedure CarregaGrid;
    procedure PesquisaProduto(vStatus : boolean);
  end;

var
  frmMovimentaEstoqueProduto: TfrmMovimentaEstoqueProduto;

implementation

{$R *.dfm}

uses untFuncoes, untPesquisa, untDM, untPrincipal;

procedure TfrmMovimentaEstoqueProduto.btnPesqProdutoClick(Sender: TObject);
begin
  PesquisaProduto(False);
end;

procedure TfrmMovimentaEstoqueProduto.btnAddClick(Sender: TObject);
begin
  if ValidaAnimal then
  begin
    if vEdita = False then
    begin
      qryGrid.Insert;
      qryGrid.FieldByName('ID').AsString := IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo'));
    end
    else
    begin
      qryGrid.Edit;
    end;
    qryGrid.FieldByName('NUMERO').AsString := edtNumero.Text;
    qryGrid.FieldByName('ID_ANIMAL').AsString := '0';
    qryGrid.FieldByName('DATA').AsString := edtData.Text;
    qryGrid.FieldByName('ID_PRODUTO').AsString := edtCodProduto.Text;
    qryGrid.FieldByName('DESCRICAO').AsString := edtDescrProduto.Text;
    qryGrid.FieldByName('QUANTIDADE').AsString := edtQtd.Text;
    qryGrid.FieldByName('TIPO').AsString := 'E';
    qryGrid.FieldByName('UNIDADE').AsString := edtUnidade.Text;
    qryGrid.Post;

    qryGrid.UpdateCursorPos;
    edtQtd.Text := '0';
  end;
end;

procedure TfrmMovimentaEstoqueProduto.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TfrmMovimentaEstoqueProduto.btnDeleteClick(Sender: TObject);      //Versao 1.1.0 - 25/05/2018
begin
  qryGrid.Delete;
  edtCodProduto.Clear;
  edtDescrProduto.Clear;
  edtQtd.Text := '0';
  vEdita := False;
end;

procedure TfrmMovimentaEstoqueProduto.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMovimentaEstoqueProduto.btnGravarClick(Sender: TObject);
var
  vID : String;
begin
  qryGrid.First;
  while not qryGrid.Eof do
  begin
    vID := IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo'));
    frmFuncoes.ExecutaSQL('Select * from MOVI_PRODUTO where id is null', 'Abrir', qryAuxiliar);
    qryAuxiliar.Insert;

    qryAuxiliar.FieldByName('ID').AsString := vID;
    qryAuxiliar.FieldByName('NUMERO').AsString := qryGrid.FieldByName('NUMERO').AsString;
    qryAuxiliar.FieldByName('DATA').AsString := qryGrid.FieldByName('DATA').AsString;
    qryAuxiliar.FieldByName('ID_PRODUTO').AsString := qryGrid.FieldByName('ID_PRODUTO').AsString;
    qryAuxiliar.FieldByName('ID_ANIMAL').AsString := qryGrid.FieldByName('ID_ANIMAL').AsString;
    qryAuxiliar.FieldByName('QUANTIDADE').AsString := qryGrid.FieldByName('QUANTIDADE').AsString;
    qryAuxiliar.FieldByName('TIPO').AsString := vTipoMovimento;
    qryAuxiliar.FieldByName('UNIDADE').AsString := qryGrid.FieldByName('UNIDADE').AsString;
    qryAuxiliar.FieldByName('ALTERACAO').AsDateTime := Date+Time;
    qryAuxiliar.FieldByName('USUARIO').AsInteger := frmPrincipal.vUsuario;
    qryAuxiliar.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

    qryAuxiliar.Post;
    qryAuxiliar.ApplyUpdates(-1);

    frmFuncoes.AutoIncre('MOVI_PRODUTO', '');
    qryGrid.Next;
  end;

  btnNovo.Enabled := True;        //Versao 1.1.0 - 25/05/2018
  btnGravar.Enabled := False;     //Versao 1.1.0 - 25/05/2018

  ShowMessage('Gravação efetuada com sucesso!');
end;

procedure TfrmMovimentaEstoqueProduto.btnNovoClick(Sender: TObject);
begin
  LimpaCampos;
  fNovo := True;
  vEdita := False;
  CarregaGrid;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  edtData.SetFocus;
  edtNumero.Text := frmFuncoes.FormataNumero(IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo')));
end;

procedure TfrmMovimentaEstoqueProduto.CarregaGrid;
Var
  vComando : String;
begin
  vComando := frmFuncoes.LerArquivoIni('MOVIESTOQUE', 'PRODUTO');
  frmFuncoes.ExecutaSQL(vComando, 'Abrir', qryGrid);

  dbgDados.Columns.Items[0].Visible := False;  //ID
  dbgDados.Columns.Items[1].Visible := False;  //NUMERO
  dbgDados.Columns.Items[2].Visible := False;  //DATA
  dbgDados.Columns.Items[3].Visible := False;  //ID_ANIMAL
  dbgDados.Columns.Items[4].Visible := True;  //ID_produto
  dbgDados.Columns.Items[5].Visible := True;  //descricao produto
  dbgDados.Columns.Items[5].Width   := 120;  //descricao produto
  dbgDados.Columns.Items[6].Visible := True;  //quantidade
  dbgDados.Columns.Items[7].Visible := False;  //tipo
  dbgDados.Columns.Items[8].Visible := False;  //unidade

  TFMTBCDField(qryGrid.FieldByName('QUANTIDADE')).DisplayFormat   := '###,####,###,##0.00';
end;

procedure TfrmMovimentaEstoqueProduto.dbgDadosDblClick(Sender: TObject);      //Versao 1.1.0 - 25/05/2018
begin
  vEdita := True;
  edtCodProduto.Text := qryGrid.FieldByName('id_Produto').AsString;
  edtDescrProduto.Text := qryGrid.FieldByName('DESCRICAO').AsString;
  edtQtd.Text := qryGrid.FieldByName('quantidade').AsString;
  edtUnidade.Text := qryGrid.FieldByName('unidade').AsString;
end;

procedure TfrmMovimentaEstoqueProduto.edtCodAnimalKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmMovimentaEstoqueProduto.edtCodProdutoChange(Sender: TObject);
begin
  if trim(edtCodProduto.Text) = '' then
    edtDescrProduto.Clear;
end;

procedure TfrmMovimentaEstoqueProduto.edtCodProdutoExit(Sender: TObject);
begin
  if trim(edtCodProduto.Text) <> '' then
    PesquisaProduto(True);
end;

procedure TfrmMovimentaEstoqueProduto.edtCodProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqProdutoClick(Self);
end;

procedure TfrmMovimentaEstoqueProduto.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmMovimentaEstoqueProduto.FormActivate(Sender: TObject);
begin
  LimpaCampos;
  CarregaGrid;
  edtNumero.SetFocus;

  if vTipoMovimento = 'S' then
    Caption := 'Movimento Estoque Produto - Saída'
  else
    Caption := 'Movimento Estoque Produto - Entrada';
end;

procedure TfrmMovimentaEstoqueProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmMovimentaEstoqueProduto.LimpaCampos;
begin
  edtNumero.Clear;
  edtData.Text := DateToStr(Date);
  edtCodProduto.Clear;
  edtDescrProduto.Clear;
  edtQtd.Text := '0';
end;

procedure TfrmMovimentaEstoqueProduto.PesquisaProduto(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProduto.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTO where ID = ' + QuotedStr(edtCodProduto.Text), 'Abrir', dm.qryProduto);
      if dm.qryProduto.RecordCount > 0 then
      begin
        edtDescrProduto.Text :=  dm.qryProduto.FieldByName('DESCRICAO').AsString;
        edtUnidade.Text := dm.qryProduto.FieldByName('UNIDADE').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodProduto.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, UNIDADE, VALOR, ESTOQUE from PRODUTO WHERE SEMEM = ' + QuotedStr('N') + ' ORDER BY DESCRICAO';
      frmPesquisa.vTela := 'MOVI_EST_PRODUTO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmMovimentaEstoqueProduto.ValidaAnimal: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;

  if edtCodProduto.Text = '' then
  begin
    ShowMessage('Insira o Produto!');
    edtCodProduto.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtQtd.Text) = '0' then
  begin
    ShowMessage('Insira a Quantidade!');
    edtQtd.SetFocus;
    vRetorno := False;
  end;

  Result := vRetorno;
end;

end.

