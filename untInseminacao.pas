unit untInseminacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmInseminacao = class(TForm)
    pnlCentro: TPanel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    dbgDados: TDBGrid;
    pnlTop: TPanel;
    edtNumero: TEdit;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    lblEmissao: TLabel;
    btnPesqProprietario: TBitBtn;
    edtDescrProprietario: TEdit;
    pnlDados: TPanel;
    lblProprietario: TLabel;
    lblTouro: TLabel;
    btnPesqTouro: TBitBtn;
    edtDescrTouro: TEdit;
    Label1: TLabel;
    btnPesqAnimal: TBitBtn;
    edtDescrAnimal: TEdit;
    Label2: TLabel;
    btnPesqServico: TBitBtn;
    edtDescrServico: TEdit;
    edtVlrUnit: TEdit;
    Label3: TLabel;
    pgctrlDados: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    edtCodTouro: TEdit;
    edtCodAnimal: TEdit;
    edtCodServico: TEdit;
    edtCodProprietario: TEdit;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    edtObs: TMemo;
    edtDtEmissao: TDateTimePicker;
    edtCodVet: TEdit;
    Label5: TLabel;
    btnPesqVet: TBitBtn;
    edtDescrVeterinario: TEdit;
    edtID: TEdit;
    qryCadInseminacao: TFDQuery;
    dtsCadInseminacao: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure btnPesqTouroClick(Sender: TObject);
    procedure btnPesqAnimalClick(Sender: TObject);
    procedure btnPesqProprietarioClick(Sender: TObject);
    procedure btnPesqServicoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtNumeroExit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesqVetClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure edtCodVetExit(Sender: TObject);
    procedure edtCodTouroExit(Sender: TObject);
    procedure edtCodServicoExit(Sender: TObject);
    procedure edtCodAnimalExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    function VerificaServico : Boolean;
    function ValidaCampos : Boolean;
  public
    { Public declarations }
    vID : string;
    fNovo : Boolean;
    procedure CarregaGrid;
    procedure PesquisaBD(vStatus : boolean);
    procedure PesquisaAnimal(vStatus : boolean);
    procedure PesquisaProprietario(vStatus : boolean);
    procedure PesquisaServico(vStatus : boolean);
    procedure PesquisaTouro(vStatus : boolean);
    procedure PesquisaVeterinario(vStatus : boolean);
  end;

var
  frmInseminacao: TfrmInseminacao;

implementation

{$R *.dfm}

uses unstCadastroVeterinario, untCadastroAnimal, untCadastroProduto,
  untCadastroProdutor, untCadastroServico, untDM, untFuncoes, untPesquisa,
  untCadastroCria, untPrincipal;

{ TfrmInseminacao }

procedure TfrmInseminacao.btnAddClick(Sender: TObject);
begin
  if VerificaServico then
  begin
    qryCadInseminacao.Append;
    qryCadInseminacao.FieldByName('id_animal').AsString := edtCodAnimal.Text;
    qryCadInseminacao.FieldByName('animal').AsString := edtDescrAnimal.Text;
    qryCadInseminacao.FieldByName('id_servico').AsString := edtCodServico.Text;
    qryCadInseminacao.FieldByName('servico').AsString := edtDescrServico.Text;
    qryCadInseminacao.FieldByName('valor').AsString := edtVlrUnit.Text;
    qryCadInseminacao.Post;

    edtCodAnimal.Clear;
    edtDescrAnimal.Clear;
    edtCodAnimal.SetFocus;
  end;
end;

procedure TfrmInseminacao.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if dm.qryCadInseminacao.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', dm.qryCadInseminacao);
      close;
    end;
  end;
end;

procedure TfrmInseminacao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInseminacao.btnGravarClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
    qryCadInseminacao.First;
    while not qryCadInseminacao.Eof do
    begin
      dm.qryCadInseminacao.Append;
      if fNovo = True then
      begin
        vID := IntToStr(frmFuncoes.AutoIncre('INSEMINACAO', 'Novo'));
        dm.qryCadInseminacao.FieldByName('id').AsString := vID;
        dm.qryCadInseminacao.FieldByName('numero').AsString := edtNumero.Text;
      end;
      dm.qryCadInseminacao.FieldByName('data').AsDateTime := edtDtEmissao.Date;
      dm.qryCadInseminacao.FieldByName('id_produtor').AsString := edtCodProprietario.Text;
      dm.qryCadInseminacao.FieldByName('id_veterinario').AsString := edtCodVet.Text;
      dm.qryCadInseminacao.FieldByName('id_touro').AsString := edtCodTouro.Text;
      dm.qryCadInseminacao.FieldByName('id_animal').AsString := qryCadInseminacao.FieldByName('id_animal').AsString;
      dm.qryCadInseminacao.FieldByName('vlr_unit').AsString := qryCadInseminacao.FieldByName('valor').AsString;
      dm.qryCadInseminacao.FieldByName('id_servico').AsString := qryCadInseminacao.FieldByName('id_servico').AsString;
      dm.qryCadInseminacao.FieldByName('observacao').AsString := edtObs.Text;
      dm.qryCadInseminacao.FieldByName('confirmada').AsString := 'N';
      dm.qryCadInseminacao.FieldByName('data_confirmacao').AsString := '01/01/1900';
      dm.qryCadInseminacao.FieldByName('alteracao').AsDateTime := Date+Time;
      dm.qryCadInseminacao.FieldByName('usuario').AsString := inttostr(frmPrincipal.vUsuario);

      frmFuncoes.AutoIncre('INSEMINACAO', 'Gravar');
      dm.qryCadInseminacao.Post;
      dm.qryCadInseminacao.ApplyUpdates(-1);
      qryCadInseminacao.Next;
    end;
  end;
  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtNumero.Enabled := True;
  ShowMessage('Gravação efetuada com sucesso!');
end;

procedure TfrmInseminacao.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  CarregaGrid;
  frmFuncoes.ExecutaSQL('Select * from INSEMINACAO WHERE ID IS NULL', 'Abrir', DM.qryCadInseminacao);
  dm.qryCadInseminacao.Append;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNumero.SetFocus;
  edtID.Text := IntToStr(frmFuncoes.AutoIncre('INSEMINACAO', 'Novo'));
  edtNumero.Text := frmFuncoes.FormataNumero(edtID.Text);
  edtNumero.Enabled := false;

  edtDtEmissao.SetFocus;

  if dm.qryConfiguracao.FieldByName('VETERINARIO_PADRAO').AsString <> '' then
  BEGIN
    edtCodVet.Text := dm.qryConfiguracao.FieldByName('VETERINARIO_PADRAO').AsString;
    PesquisaVeterinario(True);
  END;

  if dm.qryConfiguracao.FieldByName('SERVICO_PADRO').AsString <> '' then
  BEGIN
    edtCodServico.Text := dm.qryConfiguracao.FieldByName('SERVICO_PADRO').AsString;
    PesquisaServico(True);
  END;
end;

procedure TfrmInseminacao.btnPesqAnimalClick(Sender: TObject);
begin
  PesquisaAnimal(False);
end;

procedure TfrmInseminacao.btnPesqProprietarioClick(Sender: TObject);
begin
  PesquisaProprietario(False);
end;

procedure TfrmInseminacao.btnPesqServicoClick(Sender: TObject);
begin
  PesquisaServico(False);
end;

procedure TfrmInseminacao.btnPesqTouroClick(Sender: TObject);
begin
    PesquisaTouro(False);
end;

procedure TfrmInseminacao.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
end;

procedure TfrmInseminacao.btnPesqVetClick(Sender: TObject);
begin
  PesquisaVeterinario(False);
end;

procedure TfrmInseminacao.CarregaGrid;
begin
  frmFuncoes.ExecutaSQL('select A.ID as id_animal, S.ID as id_servico, A.NOME as Animal, S.DESCRICAO as Servico, S.VALOR FROM INSEMINACAO I JOIN ANIMAL A ON (A.ID = I.ID_ANIMAL) JOIN SERVICO S ON (S.ID = I.ID_SERVICO) Where I.NUMERO = ' + vID, 'Abrir', qryCadInseminacao);
  dbgDados.Columns.Items[0].Visible := False;
  dbgDados.Columns.Items[1].Visible := False;
  dbgDados.Columns.Items[2].Width := 150;
  dbgDados.Columns.Items[3].Width := 150;
  TFMTBCDField(qryCadInseminacao.FieldByName('valor')).DisplayFormat   := '###,####,###,##0.00';

end;

procedure TfrmInseminacao.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgDados.Canvas.Brush.Color := clNavy;
    dbgDados.Canvas.Font.Color := clWhite;
  end;

  dbgDados.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmInseminacao.edtNumeroExit(Sender: TObject);
begin
  if fNovo = false then
  begin
    if Trim(edtNumero.Text) <> '' then
      PesquisaBD(True);
  end;
end;

procedure TfrmInseminacao.FormActivate(Sender: TObject);
begin
  vID := '0';
  CarregaGrid;
  edtNumero.SetFocus;
  edtDtEmissao.DateTime := Date;
end;

procedure TfrmInseminacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmInseminacao.PesquisaAnimal(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodAnimal.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from ANIMAL where TIPO = ' + QuotedStr('V') + ' and ID = ' + QuotedStr(edtCodAnimal.Text), 'Abrir', DM.qryAnimal);
      if DM.qryAnimal.RecordCount > 0 then
      begin
        edtDescrAnimal.Text := DM.qryAnimal.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodAnimal.SetFocus;
        edtCodAnimal.Clear;
        edtDescrAnimal.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL where TIPO = ' + QuotedStr('V') + ' AND PROPRIETARIO = ' + QuotedStr(edtCodProprietario.Text) + ' ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtNumero.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from INSEMINACAO WHERE NUMERO = ' + QuotedStr(edtNumero.Text), 'Abrir', DM.qryCadInseminacao);
      if DM.qryCadInseminacao.RecordCount > 0 then
      begin
        vID := DM.qryCadInseminacao.FieldByName('NUMERO').AsString;
        CarregaGrid;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtNumero.SetFocus;
        edtNumero.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'INSEMINACAO';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select I.numero, I.data, A.NOME, I.CONFIRMADA from INSEMINACAO I JOIN ANIMAL A ON (I.ID_ANIMAL = A.ID) WHERE confirmada = ' + QuotedStr('N') + ' ORDER BY NUMERO' ;
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;


procedure TfrmInseminacao.PesquisaProprietario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProprietario.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID =  ' + QuotedStr(edtCodProprietario.Text), 'Abrir', DM.qryProprietario);

      if DM.qryProprietario.RecordCount > 0 then
      begin
        edtDescrProprietario.Text := DM.qryProprietario.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodProprietario.SetFocus;
        edtCodProprietario.Clear;
        edtDescrProprietario.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, NOME, INSCEST_RURAL from PRODUTOR ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaServico(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodServico.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from SERVICO where ID =  ' + QuotedStr(edtCodServico.Text), 'Abrir', DM.qryProprietario);

      if DM.qryProprietario.RecordCount > 0 then
      begin
        edtDescrServico.Text := DM.qryProprietario.FieldByName('DESCRICAO').AsString;
        edtVlrUnit.Text :=  DM.qryProprietario.FieldByName('valor').AsString;
        TFMTBCDField(edtVlrUnit).DisplayFormat   := '###,####,###,##0.00';
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodServico.SetFocus;
        edtCodServico.Clear;
        edtDescrServico.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'SERVICO';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO from SERVICO ORDER BY DESCRICAO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaTouro(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodTouro.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from ANIMAL where TIPO = ' + QuotedStr('T') + ' and ID = ' + QuotedStr(edtCodTouro.Text), 'Abrir', DM.qryAnimal);
      if DM.qryAnimal.RecordCount > 0 then
      begin
        edtDescrTouro.Text := DM.qryAnimal.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodTouro.SetFocus;
        edtCodTouro.Clear;
        edtDescrTouro.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'INSEMINACAO_T';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL where TIPO = ' + QuotedStr('T') + ' ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaVeterinario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodVet.Text), 'Abrir', DM.qryVeterinario);

    if DM.qryVeterinario.RecordCount > 0 then
    begin
      edtDescrVeterinario.Text := DM.qryVeterinario.FieldByName('nome').AsString;
    end
    else
    begin
      Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      edtCodVet.SetFocus;
      edtCodVet.Clear;
      edtDescrVeterinario.Clear;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vTela := 'ISNEMINACAO';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmInseminacao.ValidaCampos: Boolean;
begin
  Result := True;
end;

function TfrmInseminacao.VerificaServico: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;
  if Trim(edtCodServico.Text) = '' then
  begin
    ShowMessage('Informe o serviço!');
    edtCodServico.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtCodAnimal.Text) = '' then
  begin
    ShowMessage('Informe o animal!');
    edtCodAnimal.SetFocus;
    vRetorno := False;
  end;

  Result := vRetorno;
end;

procedure TfrmInseminacao.edtCodAnimalExit(Sender: TObject);
begin
  if Trim(edtCodAnimal.Text) <> '' then
  begin
    PesquisaAnimal(True);
  end;
end;

procedure TfrmInseminacao.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) <> '' then
  begin
    PesquisaProprietario(True);
  end;
end;

procedure TfrmInseminacao.edtCodServicoExit(Sender: TObject);
begin
  if Trim(edtCodServico.Text) <> '' then
  begin
    PesquisaServico(True);
  end;
end;

procedure TfrmInseminacao.edtCodTouroExit(Sender: TObject);
begin
  if Trim(edtCodTouro.Text) <> '' then
  begin
    PesquisaTouro(True);
  end;
end;

procedure TfrmInseminacao.edtCodVetExit(Sender: TObject);
begin
  if Trim(edtCodVet.Text) <> '' then
  begin
    PesquisaVeterinario(True);
  end;
end;

end.
