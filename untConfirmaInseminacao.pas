unit untConfirmaInseminacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Menus;

type
  TfrmConfirmaInseminacao = class(TForm)
    pnlCentro: TPanel;
    pnlTop: TPanel;
    lblProdutor: TLabel;
    btnPesquProprietario: TBitBtn;
    edtCodProprietario: TEdit;
    pnlRodape: TPanel;
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    btnPesquisar: TBitBtn;
    dbgConfirmadas: TDBGrid;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    lblDtConfirmacao: TLabel;
    edtProprietario: TEdit;
    edtCodVeterinario: TEdit;
    btnPesqVeterinario: TBitBtn;
    edtVeterinario: TEdit;
    Label1: TLabel;
    qryProdutor: TFDQuery;
    dtsProdutor: TDataSource;
    qryVeterinario: TFDQuery;
    dtsVeterinario: TDataSource;
    edtDtConfirmacao: TDateTimePicker;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    dbgInsemacoes: TDBGrid;
    lblNaoConfirmadas: TLabel;
    lblQtdNaoConfirmadas: TLabel;
    lblConfirmadas: TLabel;
    lblQtdConfirmadas: TLabel;
    qryInseminacoes: TFDQuery;
    dtsInseminacoes: TDataSource;
    popmnNaoConfirmadas: TPopupMenu;
    Excluir1: TMenuItem;
    popmnConfirmadas: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure btnPesqVeterinarioClick(Sender: TObject);
    procedure edtCodVeterinarioExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodProprietarioChange(Sender: TObject);
    procedure edtCodVeterinarioChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Excluir1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { Private declarations }
    vID : String;
    procedure FormataGrid(vGRD : TDBGrid);
  public
    { Public declarations }
    procedure PesquisaProdutor(vStatus : boolean);
    procedure PesquisaVeterinario(vStatus : boolean);
    function ValidaCampos : Boolean;
  end;

var
  frmConfirmaInseminacao: TfrmConfirmaInseminacao;

implementation

{$R *.dfm}

uses untDM, untFuncoes, untPesquisa, untPrincipal;

procedure TfrmConfirmaInseminacao.btnAddClick(Sender: TObject);
begin
  if DM.qryAConfirmar.IsEmpty = False then
  begin
    DM.qryConfirmados.Insert;
    DM.qryConfirmados.FieldByName('idMovi').AsString := DM.qryAConfirmar.FieldByName('idMovi').AsString;
    DM.qryConfirmados.FieldByName('idInsem').AsString := DM.qryAConfirmar.FieldByName('idInsem').AsString;
    DM.qryConfirmados.FieldByName('NUMERO').AsString := DM.qryAConfirmar.FieldByName('NUMERO').AsString;
    DM.qryConfirmados.FieldByName('PROPRIETARIO').AsString := DM.qryAConfirmar.FieldByName('PROPRIETARIO').AsString;
    DM.qryConfirmados.FieldByName('DATA').AsString := DM.qryAConfirmar.FieldByName('DATA').AsString;
    DM.qryConfirmados.FieldByName('ANIMAL').AsString := DM.qryAConfirmar.FieldByName('ANIMAL').AsString;
    DM.qryConfirmados.FieldByName('VETERINARIO').AsString := DM.qryAConfirmar.FieldByName('VETERINARIO').AsString;
    DM.qryConfirmados.FieldByName('CONFIRMADA').AsString := 'S';
    DM.qryConfirmados.FieldByName('DATA_CONFIRMACAO').AsDateTime := Date;
    DM.qryConfirmados.FieldByName('ID_PRODUTOR').AsString := DM.qryAConfirmar.FieldByName('ID_PRODUTOR').AsString;
    DM.qryConfirmados.FieldByName('ID_VETERINARIO').AsString := DM.qryAConfirmar.FieldByName('ID_VETERINARIO').AsString;
    DM.qryConfirmados.Post;
    DM.qryAConfirmar.Delete;

    lblQtdNaoConfirmadas.Caption := IntToStr(dm.qryAConfirmar.RecordCount);
    lblQtdConfirmadas.Caption := IntToStr(dm.qryConfirmados.RecordCount);
  end;
end;

procedure TfrmConfirmaInseminacao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConfirmaInseminacao.btnGravarClick(Sender: TObject);
var
  vData : string;
begin
  if dm.qryConfirmados.IsEmpty = False then
  begin
    dm.qryConfirmados.First;
    while not dm.qryConfirmados.Eof do
    begin
      qryAuxiliar.Close;
      frmFuncoes.ExecutaSQL('Select * from MOVI_INSEMINACAO WHERE ID = ' + QuotedStr(DM.qryConfirmados.FieldByName('idMovi').AsString), 'Abrir', qryAuxiliar);
      qryAuxiliar.Edit;
      qryAuxiliar.FieldByName('CONFIRMADA').AsString := 'S';
      qryAuxiliar.FieldByName('DATA_CONFIRMACAO').AsDateTime := edtDtConfirmacao.Date;
      qryAuxiliar.Post;
      qryAuxiliar.ApplyUpdates(-1);

      dm.qryConfirmados.Next;
    end;
  end;

  if DM.qryAConfirmar.IsEmpty = False then
  begin
    qryAuxiliar.Close;
    dm.qryAConfirmar.First;
    while not dm.qryAConfirmar.Eof do
    begin
      frmFuncoes.ExecutaSQL('Select * from MOVI_INSEMINACAO WHERE ID = ' + QuotedStr(DM.qryAConfirmar.FieldByName('idMovi').AsString), 'Abrir', qryAuxiliar);
      qryAuxiliar.Edit;
      qryAuxiliar.FieldByName('CONFIRMADA').AsString := 'N';
      qryAuxiliar.FieldByName('DATA_CONFIRMACAO').AsDateTime := edtDtConfirmacao.Date;
      qryAuxiliar.Post;
      qryAuxiliar.ApplyUpdates(-1);

      dm.qryAConfirmar.Next;
    end;
  end;

  qryInseminacoes.First;
  while not qryInseminacoes.Eof do
  begin
    frmFuncoes.ExecutaSQL('Select * from MOVI_INSEMINACAO WHERE ID_INSEMINACAO = ' + QuotedStr(qryInseminacoes.FieldByName('ID').AsString)+ ' and CONFIRMADA = ' + QuotedStr('A'), 'Abrir', qryAuxiliar);   //Versao 1.5.0 - 25/10/2018 - RS
    if qryAuxiliar.RecordCount = 0 then     //Versao 1.5.0 - 25/10/2018 - RS
    begin
      qryInseminacoes.Edit;
      qryInseminacoes.FieldByName('FINALIZADA').AsString := 'S';
      qryInseminacoes.FieldByName('DT_FINALIZADA').AsDateTime := edtDtConfirmacao.Date;
      qryInseminacoes.Post;
      qryInseminacoes.ApplyUpdates(-1);
    end;

    qryInseminacoes.Next;
  end;

  ShowMessage('Gravação efetuada com sucesso');
  DM.qryConfirmados.Close;
  DM.qryAConfirmar.Close;
  lblQtdNaoConfirmadas.Caption := IntToStr(0);
  lblQtdConfirmadas.Caption := IntToStr(0);
end;

procedure TfrmConfirmaInseminacao.btnPesquisarClick(Sender: TObject);
var
  vComando, vComandoConfirmados, vComandoInseminacoes : string;
begin
  if ValidaCampos then
  begin
    vComandoInseminacoes := 'Select * from INSEMINACAO where FINALIZADA = ' + QuotedStr('N');   //Versao 1.1.1 - 15/06/2018
    vComando := 'select I.numero, P.NOME AS PROPRIETARIO, I.DATA, A.NOME AS ANIMAL, V.NOME AS VETERINARIO, MI.CONFIRMADA, MI.DATA_CONFIRMACAO, I.ID_PRODUTOR, I.ID_VETERINARIO, MI.ID as idMovi, I.ID as idInsem from MOVI_INSEMINACAO MI ' +
      ' JOIN INSEMINACAO I ON (I.ID = MI.ID_INSEMINACAO) ' +
      ' JOIN ANIMAL A ON (A.ID = MI.ID_ANIMAL) ' +
      ' JOIN PRODUTOR P ON (P.ID = I.ID_PRODUTOR) ' +
      ' JOIN VETERINARIO V ON (V.ID = I.ID_VETERINARIO) ' +
      ' Where ';

    vComandoConfirmados := vComando;

    vComando := vComando + ' MI.confirmada = ' + QuotedStr('A');


    if edtCodProprietario.Text <> '' then
    begin
      vComando := vComando + ' and I.id_produtor = ' + QuotedStr(edtCodProprietario.Text);
      vComandoInseminacoes := vComandoInseminacoes + ' and id_produtor = ' + QuotedStr(edtCodProprietario.Text);
    end;

    if edtCodVeterinario.Text <> '' then
    begin
      vComando := vComando + ' and I.ID_VETERINARIO = ' + QuotedStr(edtCodVeterinario.Text);
      vComandoInseminacoes := vComandoInseminacoes + ' and ID_VETERINARIO = ' + QuotedStr(edtCodVeterinario.Text);
    end;

    frmFuncoes.ExecutaSQL(vComando + ' order by PROPRIETARIO', 'Abrir', DM.qryAConfirmar);
    frmFuncoes.ExecutaSQL(vComandoConfirmados + ' MI.ID IS NULL ORDER BY PROPRIETARIO', 'Abrir', DM.qryConfirmados);
    frmFuncoes.ExecutaSQL(vComandoInseminacoes, 'Abrir', qryInseminacoes);
  end;

  FormataGrid(dbgConfirmadas);
  FormataGrid(dbgInsemacoes);
  lblQtdNaoConfirmadas.Caption := IntToStr(dm.qryAConfirmar.RecordCount);
  lblQtdConfirmadas.Caption := IntToStr(dm.qryConfirmados.RecordCount);
end;

procedure TfrmConfirmaInseminacao.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProdutor(False);
end;

procedure TfrmConfirmaInseminacao.btnPesqVeterinarioClick(Sender: TObject);
begin
  PesquisaVeterinario(False);
end;

procedure TfrmConfirmaInseminacao.btnRemoveClick(Sender: TObject);
begin
  if DM.qryConfirmados.IsEmpty = False then
  begin
    DM.qryAConfirmar.Insert;
    DM.qryAConfirmar.FieldByName('idMovi').AsString := DM.qryConfirmados.FieldByName('idMovi').AsString;
    DM.qryAConfirmar.FieldByName('idInsem').AsString := DM.qryConfirmados.FieldByName('idInsem').AsString;
    DM.qryAConfirmar.FieldByName('NUMERO').AsString := DM.qryConfirmados.FieldByName('NUMERO').AsString;
    DM.qryAConfirmar.FieldByName('PROPRIETARIO').AsString := DM.qryConfirmados.FieldByName('PROPRIETARIO').AsString;
    DM.qryAConfirmar.FieldByName('DATA').AsString := DM.qryConfirmados.FieldByName('DATA').AsString;
    DM.qryAConfirmar.FieldByName('ANIMAL').AsString := DM.qryConfirmados.FieldByName('ANIMAL').AsString;
    DM.qryAConfirmar.FieldByName('VETERINARIO').AsString := DM.qryConfirmados.FieldByName('VETERINARIO').AsString;
    DM.qryAConfirmar.FieldByName('CONFIRMADA').AsString := 'N';
    DM.qryAConfirmar.FieldByName('DATA_CONFIRMACAO').AsString := '01/01/1900';
    DM.qryAConfirmar.FieldByName('ID_PRODUTOR').AsString := DM.qryConfirmados.FieldByName('ID_PRODUTOR').AsString;
    DM.qryAConfirmar.FieldByName('ID_VETERINARIO').AsString := DM.qryConfirmados.FieldByName('ID_VETERINARIO').AsString;
    DM.qryAConfirmar.Post;

    DM.qryConfirmados.Delete;
    lblQtdNaoConfirmadas.Caption := IntToStr(dm.qryAConfirmar.RecordCount);
    lblQtdConfirmadas.Caption := IntToStr(dm.qryConfirmados.RecordCount);
  end;
end;

procedure TfrmConfirmaInseminacao.edtCodProprietarioChange(Sender: TObject);
begin
  if edtCodProprietario.text = '' then
    edtProprietario.Clear;
end;

procedure TfrmConfirmaInseminacao.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) <> '' then      //Versao 1.1.1 - 15/06/2018
    PesquisaProdutor(True);
end;

procedure TfrmConfirmaInseminacao.edtCodVeterinarioChange(Sender: TObject);
begin
  if edtCodVeterinario.text = '' then
    edtVeterinario.Clear;
end;

procedure TfrmConfirmaInseminacao.edtCodVeterinarioExit(Sender: TObject);
begin
  if Trim(edtVeterinario.Text) <> '' then
    PesquisaVeterinario(True);
end;

procedure TfrmConfirmaInseminacao.Excluir1Click(Sender: TObject);
begin
  dm.qryAConfirmar.Delete;                        //Versao 1.3.1 - 23/08/2018
  lblQtdNaoConfirmadas.Caption := IntToStr(dm.qryAConfirmar.RecordCount);
  lblQtdConfirmadas.Caption := IntToStr(dm.qryConfirmados.RecordCount);
end;

procedure TfrmConfirmaInseminacao.FormActivate(Sender: TObject);
begin
  edtDtConfirmacao.Date := Date;
  qryInseminacoes.Close;
  DM.qryAConfirmar.Close;
  DM.qryConfirmados.Close;
end;

procedure TfrmConfirmaInseminacao.FormataGrid(vGRD: TDBGrid);
begin
  vGRD.Columns.Items[0].Width := 70;
  vGRD.Columns.Items[1].Width := 220;
  vGRD.Columns.Items[2].Width := 70;
  vGRD.Columns.Items[3].Width := 150;
  vGRD.Columns.Items[4].Width := 180;

  vGRD.Columns.Items[5].Visible := False;
  vGRD.Columns.Items[6].Visible := False;
  vGRD.Columns.Items[7].Visible := False;
  vGRD.Columns.Items[8].Visible := False;
  vGRD.Columns.Items[9].Visible := False;
  vGRD.Columns.Items[10].Visible := False;
end;

procedure TfrmConfirmaInseminacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmConfirmaInseminacao.MenuItem1Click(Sender: TObject);      //Versao 1.3.1 - 23/08/2018
begin
  dm.qryConfirmados.Delete;          //Versao 1.3.1 - 23/08/2018
  lblQtdNaoConfirmadas.Caption := IntToStr(dm.qryAConfirmar.RecordCount);
  lblQtdConfirmadas.Caption := IntToStr(dm.qryConfirmados.RecordCount);
end;

procedure TfrmConfirmaInseminacao.PesquisaProdutor(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProprietario.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID =  ' + QuotedStr(edtCodProprietario.Text), 'Abrir', qryProdutor);

      if qryProdutor.RecordCount > 0 then
      begin
        edtProprietario.Text := qryProdutor.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'CONFIRMA_INS';
      frmPesquisa.vComando := 'Select ID, NOME, INSC_RURAL from PRODUTOR';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmConfirmaInseminacao.PesquisaVeterinario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodVeterinario.Text), 'Abrir', qryVeterinario);

    if qryVeterinario.RecordCount > 0 then
    begin
      edtVeterinario.Text := qryVeterinario.FieldByName('nome').AsString;
    end
    else
    begin
      Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      edtCodVeterinario.SetFocus;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vTela := 'CONFIRMA_INS';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmConfirmaInseminacao.ValidaCampos: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;


  Result := vRetorno;
end;

end.
