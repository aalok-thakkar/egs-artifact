package sql.lang;

import sql.lang.ast.Environment;
import sql.lang.ast.table.TableNode;
import sql.lang.exception.SQLEvalException;

/**
 * Created by clwang on 12/16/15.
 */
public class SQLQuery {
    TableNode queryAst;

    public SQLQuery(TableNode ast) {
        this.queryAst = ast;
    }

    public Table execute() {
        try {
            return queryAst.eval(new Environment());
        } catch (SQLEvalException e) {
            e.printStackTrace();
            System.exit(-1);
        }
        return null;
    }

    @Override
    public String toString() {
        return queryAst.prettyPrint(0, false);
    }
}
