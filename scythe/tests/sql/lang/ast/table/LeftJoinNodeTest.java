package sql.lang.ast.table;

import org.junit.Test;
import sql.lang.Table;
import sql.lang.ast.Environment;
import util.Pair;
import util.TableInstanceParser;

import java.util.Arrays;

/**
 * Created by clwang on 10/6/16.
 */
public class LeftJoinNodeTest {

    String src1 =
            "| id | broId | home|  datetime  | player  | resource |" + "\r\n" +
                    "|----------------------------------------------------|" + "\r\n" +
                    "| 1  | 1     | 10  | a | john    | 399      |" + "\r\n" +
                    "| 2  | 3     | 11  | a | juliet  | 244      |" + "\r\n" +
                    "| 5  | 4     | 12  | a | borat   | 555      |" + "\r\n" +
                    "| 3  | 5     | 10  | b | john    | 300      |" + "\r\n" +
                    "| 4  | 7     | 11  | b | juliet  | 200      |" + "\r\n" +
                    "| 6  | 6     | 12  | b | borat   | 500      |" + "\r\n" +
                    "| 7  | 5     | 13  | c | borat   | 600      |" + "\r\n" +
                    "| 8  | 8     | 13  | d | borat   | 700      |";

    String src2 =
            "| id | tid   |" + "\r\n" +
                    "|------------|" + "\r\n" +
                    "| 1  | a     |" + "\r\n" +
                    "| 2  | a     |" + "\r\n" +
                    "| 5  | c     |";

    String src3 =
            "| id | broId | home|  datetime  | player  | resource |" + "\r\n" +
                    "|----------------------------------------------------|" + "\r\n" +
                    "| 1  | 1     | 10  | a | john    | 399      |" + "\r\n" +
                    "| 2  | 3     | 11  | a | juliet  | 244      |" + "\r\n" +
                    "| 5  | 4     | 12  | a | borat   | 555      |" + "\r\n" +
                    "| 3  | 5     | 10  | b | john    | 300      |" + "\r\n" +
                    "| 4  | 7     | 11  | b | juliet  | 200      |" + "\r\n" +
                    "| 6  | 6     | 12  | b | borat   | 500      |" + "\r\n" +
                    "| 8  | 8     | 13  | d | borat   | 700      |";

    String src4 =
            "| id | tid   |" + "\r\n" +
                    "|------------|" + "\r\n" +
                    "| 1  | a     |" + "\r\n" +
                    "| 2  | a     |" + "\r\n" +
                    "| 5  | c     |";

    Table t1 = TableInstanceParser.parseMarkDownTable("t1", src1);
    Table t2 = TableInstanceParser.parseMarkDownTable("t2", src2);
    Table t3 = TableInstanceParser.parseMarkDownTable("t3", src3);
    Table t4 = TableInstanceParser.parseMarkDownTable("t4", src4);


    @Test
    public void testEval() throws Exception {
        TableNode tn = new LeftJoinNode(new NamedTable(t1),
                new NamedTable(t2),
                Arrays.asList(new Pair<String, String>("t1.id", "t2.id")));

        System.out.println(tn.eval(new Environment()));

        TableNode tn2 = new LeftJoinNode(new NamedTable(t3),
                new NamedTable(t4),
                Arrays.asList(new Pair<String, String>("t3.id", "t4.id")));

        System.out.println(tn2.eval(new Environment()));

    }

}