s = ".type EXPR\n.type NUM\n.type STR\n.type LOC\n"
with open("rules.t", "r") as rule_file:
    for line in rule_file.readlines():
        rel_name = line[1:line.find("(")] if line[0] == "*" else line[0:line.find("(")]
        arg_types = line[line.find("(")+1:line.find(")")].split(",")
        s += ".decl " + rel_name + "(" + ",".join("v" + str(i) + ": " + arg_types[i] for i in range(len(arg_types))) + ")\n"
        if line[0] == "*":
            s += ".input " + rel_name
        else:
            s += ".output " + rel_name
        s += "\n"
print(s)
