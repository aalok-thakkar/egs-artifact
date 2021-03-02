package forward_enumeration.table_enumerator;

import forward_enumeration.context.EnumContext;
import forward_enumeration.container.QueryContainer;
import forward_enumeration.canonical_enum.components.EnumAggrTableNode;
import forward_enumeration.canonical_enum.components.EnumFilterNamed;
import forward_enumeration.canonical_enum.components.EnumJoinTableNodes;
import forward_enumeration.canonical_enum.components.EnumProjection;
import sql.lang.Table;
import sql.lang.ast.table.NamedTable;
import sql.lang.ast.table.TableNode;
import util.RenameTNWrapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by clwang on 3/21/16.
 */
public class CanonicalTableEnumerator extends AbstractTableEnumerator {

    @Override
    public List<TableNode> enumTable(EnumContext ec, int depth) {

        QueryContainer qc = QueryContainer.initWithInputTables(ec.getInputs(), QueryContainer.ContainerType.TableLinks);
        enumTableWithoutProj(ec, qc, depth); // ec will memoize these intermediate results, since the result pool is shared

        ec.setTableNodes(qc.getRepresentativeTableNodes());
        List<TableNode> tns = EnumProjection.enumProjection(ec.getTableNodes(), ec.getOutputTable());
        qc.insertQueries(tns);

        return tns;
    }

    public static QueryContainer enumTableWithoutProj(EnumContext ec, QueryContainer qc, int depth) {



        ec.setTableNodes(qc.getRepresentativeTableNodes());
        List<TableNode> tns = EnumFilterNamed.enumFilterNamed(ec, true)
                .stream().map(tn -> RenameTNWrapper.tryRename(tn)).collect(Collectors.toList());
        qc.insertQueries(tns);

        ec.setTableNodes(qc.getRepresentativeTableNodes());
        tns = EnumAggrTableNode.enumAggrNodeWFilter(ec)
                .stream().map(tn -> RenameTNWrapper.tryRename(tn)).collect(Collectors.toList());
        qc.insertQueries(tns);

        for (int i = 1; i <= depth; i ++) {
            ec.setTableNodes(qc.getRepresentativeTableNodes());
            tns = EnumJoinTableNodes.enumJoinWithFilter(ec);
            System.out.println("There are " + tns.size() + " tables in the enumeration of this level(" + i + ")");
            qc.insertQueries(tns.stream().map(tn -> RenameTNWrapper.tryRename(tn)).collect(Collectors.toList()));
        }

        return qc;
    }

}
