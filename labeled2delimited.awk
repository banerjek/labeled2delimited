BEGIN {
    RS   = ""
    FS   = "\n"
    OFS  = "\t"
    ofmt = "\"%s\"%s"
}
NR == FNR {
    for (i=1; i<=NF; i++) {
        name = $i
        sub(/=.*/,"",name)
        if ( !seen[name]++ ) {
            nr2name[++numNames] = name
        }
    }
    next
}
FNR == 1 {
    for (nameNr=1; nameNr<=numNames; nameNr++) {
        name = nr2name[nameNr]
        printf ofmt, name, (nameNr<numNames ? OFS : ORS)
    }
}
{
    delete name2val
    for (fldNr=1; fldNr<=NF; fldNr++) {
        name = val = $fldNr
        sub(/=.*/,"",name)
        sub(/[^=]+=/,"",val)
        name2val[name] = val
    }

    for (nameNr=1; nameNr<=numNames; nameNr++) {
        name = nr2name[nameNr]
        val  = name2val[name]
        printf ofmt, val, (nameNr<numNames ? OFS : ORS)
    }
}
