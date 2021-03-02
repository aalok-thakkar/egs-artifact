package sql.lang.datatype;

/**
 * Created by clwang on 10/6/16.
 */
public class NullVal implements Value {

    ValType type;

    public NullVal(ValType vt) {
        this.type = vt;
    }

    @Override
    public String getVal() {
        return "NULL[[" + this.type + "]]";
    }

    @Override
    public String toString() {
        return this.getVal();
    }

    @Override
    public Value duplicate() {
        return new NullVal(type);
    }

    @Override
    public int hashCode() {
        return this.toString().hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof NullVal) {
            if (((NullVal) obj).getValType().equals(this.type))
                return true;
        }
        return false;
    }

    @Override
    public ValType getValType() {
        return this.type;
    }
}
