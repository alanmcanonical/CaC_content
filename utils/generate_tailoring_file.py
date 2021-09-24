#!/usr/bin/python3
import ruamel.yaml
import re
import lxml.etree as etree
import sys

def search_comment(raw_yaml, linenum):
    result=None
    while result == None:
        assert(linenum >= 0)
        result=search_comment.prog.match(raw_yaml[linenum])
        if result:
            return raw_yaml[linenum]
        else:
            linenum -= 1
search_comment.prog = re.compile("^\s*#+\s*((?:\d+\.)*\d+\.?|UBTU-.*)\s+")

def process_comment(s):
    # Remove newline chars and the shebang
    return s.strip(' \n#')

def print_xml_comment(comment, add_line_before):
    if add_line_before:
        print('')
    print(f"<!-- { comment } -->")

def process_var(doc, var, val):
    root = doc.getroot()
    for xmlVal in root.findall(".//{http://checklists.nist.gov/xccdf/1.1}Value"):
        if xmlVal.get('id') == var:
            for xmlval in xmlVal.findall(".//{http://checklists.nist.gov/xccdf/1.1}value"):
                if xmlval.get('selector') == val:
                    return (None, xmlval.text)

    return (Exception("No value found for variable { var }!"), None)

def print_xml_var(err, var, pval):
    if err != None:
        str_err = str(err)
        print(f'<!-- Could not extract value from variable { var } ! Error: { str_err } -->')
    else:
        print(f'<xccdf:set-value idref="{ var }">{ pval }</xccdf:set-value>')

# If the raw rule name contains a '!' character, returns the name without it and return flag select as False
def process_rule(rule):
    if rule.startswith("!"):
        return (rule.lstrip('!'), False)
    return (rule, True)

def print_xml_rule(rule, is_selected):
    print(f'<xccdf:select idref="{ rule }" selected="' + str(is_selected).lower() + '"/>')

def create_tailoring_file(parsed_yaml, raw_yaml, xccdf_doc):
    yaml_sel=parsed_yaml["selections"]
    prog=re.compile('^([^=]+)=(.*)$') # Regexp to fetch variable lines
    prev_linenum=-1
    for i in range(len(yaml_sel)):
        linenum=yaml_sel.lc.data[i][0]
        # If it's the first linenum of a block, get the comment
        if prev_linenum != (linenum - 1):
            comment_line = search_comment(raw_yaml, linenum - 1) # Start searching the previous line
            pc = process_comment(comment_line)
            if prev_linenum != -1:
                print_xml_comment(pc, True)
            else: # First line doesn't need spaces
                print_xml_comment(pc, False)

        # Now line can be a variable assignment or a rule line
        result=prog.match(yaml_sel[i])

        if result:
            # Real value must be extract from XCCDF file
            var = result.group(1)
            val = result.group(2)
            err, pval = process_var(xccdf_doc, var, val)
            print_xml_var(err, var, pval)
        else:
            prule, is_selected = process_rule(yaml_sel[i])
            print_xml_rule(prule, is_selected)

        prev_linenum=linenum


USAGE = f"Usage: python {sys.argv[0]} <Profile file path> <XCCDF file path>"
if __name__ == '__main__':
    parsed_yaml=None
    raw_yaml=None

    if len(sys.argv) != 3:
        print(USAGE, file=sys.stderr)
        sys.exit(1)

    yaml_path = sys.argv[1]
    xccdf_path = sys.argv[2]

    try:
        with open(yaml_path, 'r') as yaml_file:
            parsed_yaml=ruamel.yaml.round_trip_load(yaml_file)
            yaml_file.seek(0)
            raw_yaml=yaml_file.readlines()

    except OSError as err:
        print("Could not open profile file", file=sys.stderr)
        sys.exit(1)

    xccdf_doc = None
    try:
        xccdf_doc = etree.parse(xccdf_path)
    except etree.XMLSyntaxError as err:
        print("Could not process XCCDF file", file=sys.stderr)
        sys.exit(1)

    create_tailoring_file(parsed_yaml, raw_yaml, xccdf_doc)

    sys.exit(0)
