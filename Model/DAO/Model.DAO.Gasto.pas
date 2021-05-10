unit Model.DAO.Gasto;

interface

Uses
  DataModule, Model.Entidade.Gasto, System.DateUtils, uControleGasto,
  Model.Conexao.Interfaces, Model.Conexao.FireDac, Model.DAO.Interfaces;

type
  TModelDAOGasto = class(TInterfacedObject, IModelDAOInterface<TEntidadeGasto>)
  private
    FEntidadeGasto: TEntidadeGasto;
    FConexao: iModelConexaoInterfaces;
  public
    constructor Create;
    destructor Destroy; override;

    function Entidade: TEntidadeGasto;
    function Inserir: IModelDAOInterface<TEntidadeGasto>;
  end;

implementation

uses
  uUtils, System.SysUtils;

{ TModelDAOGasto }

constructor TModelDAOGasto.Create;
begin
  FEntidadeGasto := TEntidadeGasto.Create(Self);
  FConexao := TModelConexaoFiredac.Criar;
end;

destructor TModelDAOGasto.Destroy;
begin
  if Assigned(FEntidadeGasto) then
    FEntidadeGasto.DisposeOf;

  inherited
end;

function TModelDAOGasto.Entidade: TEntidadeGasto;
begin
  Result := FEntidadeGasto;
end;

function TModelDAOGasto.Inserir: IModelDAOInterface<TEntidadeGasto>;
const
  CONST_SQL_GASTO = 'INSERT INTO GASTO ('
                  + '  DATA_GASTO,'
                  + '  COD_TIPO_GASTO,'
                  + '  VALOR_GASTO '
                  + ') '
                  + 'VALUES ('
                  + '  :DATA_GASTO,'
                  + '  :COD_TIPO_GASTO,'
                  + '  :VALOR_GASTO'
                  + ') ';

begin
  FConexao
    .AdicionarSQL(CONST_SQL_GASTO)
    .AdicionarParametros('DATA_GASTO', FEntidadeGasto.Data)
    .AdicionarParametros('COD_TIPO_GASTO', FEntidadeGasto.Tipo)
    .AdicionarParametros('VALOR_GASTO', FEntidadeGasto.Valor)
  .Executar;

  Result := Self;
end;

end.
