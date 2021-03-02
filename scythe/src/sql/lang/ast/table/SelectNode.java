package sql.lang.ast.table;

import forward_enumeration.context.EnumContext;
import forward_enumeration.primitive.parameterized.InstantiateEnv;
import sql.lang.ast.filter.EmptyFilter;
import util.CostEstimator;
import util.Pair;
import sql.lang.datatype.ValType;
import sql.lang.datatype.Value;
import sql.lang.Table;
import sql.lang.TableRow;
import sql.lang.ast.Environment;
import sql.lang.ast.Hole;
import sql.lang.ast.val.NamedVal;
import sql.lang.ast.val.ValNode;
import sql.lang.ast.filter.Filter;
import sql.lang.exception.SQLEvalException;
import sql.lang.trans.ValNodeSubstBinding;
import util.IndentionManagement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by clwang on 12/16/15.
 */
public class SelectNode extends TableNode {

    List<ValNode> columns;
    TableNode tableNode;
    Filter filter;

    public SelectNode(List<ValNode> columns, TableNode node, Filter filter) {
        this.columns = columns;
        this.tableNode = node;
        this.filter = filter;
    }

    @Override
    public Table eval(Environment env) throws SQLEvalException {

        Table table = tableNode.eval(env);

        Table resultTable = table.duplicate();

        // initialize result table data
        resultTable.getSchema().clear();
        for (ValNode vn : columns) {
            resultTable.getSchema().add(vn.getName());
        }

        // initialize result table content
        resultTable.getContent().clear();
        resultTable.updateName("anonymous");

        for (TableRow row : table.getContent()) {
            // The name and value binding between field names and values
            Map<String, Value> rowBinding = new HashMap<String, Value>();

            // extend the evaluation environment for this column
            if (table.getName().equals("anonymous")) {
                for (int i = 0; i < table.getSchema().size(); i ++) {
                    rowBinding.put(table.getSchema().get(i), row.getValue(i));
                }
            } else {
                for (int i = 0; i < table.getSchema().size(); i ++) {
                    rowBinding.put(
                            table.getName() + "." + table.getSchema().get(i),
                            row.getValue(i));
                }
            }

            Environment extEnv = env.extend(rowBinding);

            if (filter.filter(extEnv)) {

                List<Value> rowContent = new ArrayList<Value>();
                for (ValNode vn : this.columns) {
                    rowContent.add(vn.eval(extEnv));
                }
                TableRow newRow = TableRow.TableRowFromContent(
                        resultTable.getName(),
                        resultTable.getSchema(),
                        rowContent);

                resultTable.getContent().add(newRow);
            }
        }

        return resultTable;
    }

    @Override
    public List<String> getSchema() {
        List<String> schema = new ArrayList<String>();
        for (ValNode vn : columns) {
            schema.add(vn.getName());
        }
        return schema;
    }

    @Override
    public String getTableName() {
        return "anonymous";
    }

    @Override
    public List<ValType> getSchemaType() {
        List<String> tableSchema = this.tableNode.getSchema();
        List<ValType> tableSchemaType = this.tableNode.getSchemaType();

        List<ValType> schemaTypes = new ArrayList<ValType>();

        for (ValNode n : columns) {
            if (n instanceof NamedVal) {
                String name = n.getName();
                if (tableNode.getTableName().equals("anonymous"))
                    name = n.getName().substring(n.getName().indexOf(".") + 1);
                for (int i = 0; i < tableSchema.size(); i ++) {
                    if (tableSchema.get(i).equals(name)) {
                        schemaTypes.add(tableSchemaType.get(i));
                        break;
                    }
                }
            } else {
                schemaTypes.add(n.getType(new EnumContext()));
            }
        }

        return schemaTypes;
    }

    @Override
    public int getNestedQueryLevel() {
        if (filter.getNestedQueryLevel() > tableNode.getNestedQueryLevel())
            return filter.getNestedQueryLevel() + 1;
        else
            return tableNode.getNestedQueryLevel() + 1;
    }

    @Override
    public String prettyPrint(int indentLv, boolean asSubquery) {

        // determine if it is select all
        boolean selectFieldsAllSame = false;
        if (tableNode.getSchema().size() == columns.size()) {
            selectFieldsAllSame = true;
            for (int i = 0; i < tableNode.getSchema().size(); i ++) {
                if (! tableNode.getSchema().get(i).equals(columns.get(i).prettyPrint(0))) {
                    selectFieldsAllSame = false;
                    break;
                }
            }
        }

        if (selectFieldsAllSame && (this.filter instanceof EmptyFilter)) {
            return IndentionManagement.addIndention( tableNode.prettyPrint(0, true), indentLv);
        }

        String result = "";

        result += "Select ";

        String selectArg = "";

        boolean flag = true;
        for (ValNode s : this.columns) {
            if (flag) {
                selectArg += s.prettyPrint(0);
                flag = false;
            } else
                selectArg += "," + s.prettyPrint(0);
        }

        if (selectFieldsAllSame)
            result += "*\r\n";
        else
            result += selectArg + "\r\n";

        result += " From\r\n";

        result += tableNode.prettyPrint(1, true);

        result += "\r\n";
        if (! (this.filter instanceof EmptyFilter)) {
            result += " Where ";
            result += filter.prettyPrint(1).trim();
        }

        if (asSubquery)
            result = "(" + result + ")";
        return IndentionManagement.addIndention(result, indentLv);
    }

    @Override
    public List<Hole> getAllHoles() {
        List<Hole> result = new ArrayList<>();
        columns.forEach(c -> result.addAll(c.getAllHoles()));
        result.addAll(tableNode.getAllHoles());
        result.addAll(filter.getAllHoles());
        return result;
    }

    @Override
    public TableNode instantiate(InstantiateEnv env) {
        return new SelectNode(
                this.columns.stream()
                        .map(c -> c.instantiate(env)).collect(Collectors.toList()),
                tableNode.instantiate(env),
                filter.instantiate(env));
    }

    @Override
    public TableNode substNamedVal(ValNodeSubstBinding vnsb) {
        return new SelectNode(
                this.columns.stream().map(c -> c.subst(vnsb)).collect(Collectors.toList()),
                tableNode.substNamedVal(vnsb),
                filter.substNamedVal(vnsb));
    }

    @Override
    public List<NamedTable> namedTableInvolved() {
        List<TableNode> result = new ArrayList<>();
        // TODO: add filter stuff in future
        return tableNode.namedTableInvolved();
    }

    @Override
    public TableNode tableSubst(List<Pair<TableNode,TableNode>> pairs) {

        TableNode core = this.tableNode.tableSubst(pairs);

        List<String> currentSchema = tableNode.getSchema();
        List<String> newSchema = core.getSchema();

        ValNodeSubstBinding vnsb = new ValNodeSubstBinding();
        for (int i = 0; i < currentSchema.size(); i++) {
            vnsb.addBinding(
                    new Pair<>(
                            new NamedVal(currentSchema.get(i)),
                            new NamedVal(newSchema.get(i))));
        }

        TableNode sn = new SelectNode(
            columns.stream().map(c -> c.subst(vnsb)).collect(Collectors.toList()),
            core,
            filter.substNamedVal(vnsb)
        );

        return sn;
    }

    @Override
    public List<String> originalColumnName() {
        List<Integer> indices = new ArrayList<>();
        for (ValNode c : this.columns) {
            if (! (c instanceof  NamedVal))
                indices.add(-1);
            else {
                boolean added = false;
                for (int i = 0; i < this.tableNode.getSchema().size(); i ++) {
                    if (this.tableNode.getSchema().get(i).equals(c.getName())) {
                        indices.add(i);
                        added = true;
                        break;
                    }
                }
                if (! added) {
                    System.err.println("[SelectNode250] Unrecognized schema.");
                    indices.add(-1);
                }
            }
        }
        List<String> innerLevelColumnName = this.tableNode.originalColumnName();
        List<String> result = new ArrayList<>();
        for (Integer i : indices) {
            if (i == -1) {
                result.add("none-col-name");
            } else {
                result.add(innerLevelColumnName.get(i));
            }
        }
        return result;
    }

    public TableNode getTableNode() { return this.tableNode; }
    public Filter getFilter() { return this.filter; }
    public List<ValNode> getColumns() { return this.columns; }

    @Override
    public double estimateAllFilterCost() {
        double cost = tableNode.estimateAllFilterCost();
        double filterCost = CostEstimator.estimateFilterCost(this.filter,
                TableNode.nameToOriginMap(this.getSchema(), originalColumnName()));

        if (tableNode instanceof RenameTableNode) {
            if (((RenameTableNode) tableNode).tableNode instanceof AggregationNode) {
                filterCost = filterCost * 1;
            } else if (((RenameTableNode) tableNode).tableNode instanceof JoinNode) {
                filterCost = filterCost * 1;
            }
        }

        return cost + filterCost;
    }

    @Override
    public List<Value> getAllConstants() {
        List<Value> list = new ArrayList<>();
        list.addAll(tableNode.getAllConstants());
        list.addAll(filter.getAllConstatnts());
        return list;
    }


    public String getQuerySkeleton() {
        return "(S " + tableNode.getQuerySkeleton() + ")";
    }

}
