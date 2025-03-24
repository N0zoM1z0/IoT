#! /usr/bin/awk -f
# 
# parse and output rules into common and specified wan dirs
# Usage: $0 <config|reset> rules.sh [dir]
# ARGV[1]: config|reset
# ARGV[2]: path/to/rules.sh
# ARGV[3]: single|whole
# ARGV[4]: dir|script
# 

BEGIN {
	if (ARGC < 3) {
		print "Usage: " ARGV[0] " <config|reset> <path/to/rules.sh> <single|whole> <dir|script>";
		exit 1;
	}

	OP = ARGV[1];
	R_FILE = ARGV[2];
	SINGLE = ARGV[3];
	TARGET = ARGV[4];

	ARGV[1] = R_FILE;
	ARGC = 2;

	WAN_ARRAY[0] = "1";
	FILES_ARRAY[0] = "1";
	ROOT_DIR = "/tmp/.wan_rules";
	CMN_DIR = ROOT_DIR "/common/";
}

function new_file(dir, file)
{
	path = dir "/" file;
	
	if (FILES_ARRAY[path] == "1") {
		return;
	}
	FILES_ARRAY[path] = "1";

	print "#!/bin/sh" > path;
	fflush(path);

	system("chmod a+x " path);
}

function init_wan(wan)
{
	dir = "";
	if (SINGLE == "single") {

		dir = ROOT_DIR "/" wan "/" OP "/" TARGET;
		system("mkdir -p " dir);

	} else {

		dir = ROOT_DIR "/" wan "/" OP;
		system("mkdir -p " dir);
		new_file(dir, TARGET);

	}
}

function getsubstr(str, start, endstr)
{
	idx = index(str, endstr);
	return substr(str, start, idx - start);
}

function getprestr(str)
{
	split(str,tA,"_");
	return tA[1]"_"tA[2]"_"tA[3]"_"tA[4];
}

function print_rule(wan, rule)
{
	file = "";

	if (SINGLE == "single") {

		name = getsubstr(rule, 1, ":");
		if (length(name) <= 0) {
			return;
		}

		rule = gensub(/[^:]+:/, "", "1", rule);

		dir = ROOT_DIR "/" wan "/" OP "/" TARGET;
		new_file(dir, name);
		
		file = dir "/" name;

	} else {

		file = ROOT_DIR "/" wan "/" OP "/" TARGET;

	}

	print rule >> file;
}

{
	if ($0 ~ /^#/ || $1 ~ /^#/) {
		next;
	}

	if ($0 ~ /IP_/ || $0 ~ /PPP_/) {
		# print rule to IP_I_I_I
		wan=""
		name=""
		# awk in busybox do not support $NF
		for (i = 1; 1 == 1; i++) {
			if ($i ~ /IP_/ || $i ~ /PPP_/) {
				name = getsubstr($i, 3, "}");
				wan = getprestr(name);	
				break;
			}
		}

		if (length(wan) == 0) {
			next;
		}

		if (WAN_ARRAY[wan] != "1") {
			WAN_ARRAY[wan] = "1";
			init_wan(wan);
		}

		print_rule(wan, $0);
	
	} else {
		# print rule to common
		wan = "common";
		
		if (WAN_ARRAY[wan] != "1") {
			WAN_ARRAY[wan] = "1";
			init_wan(wan);
		}

		print_rule(wan, $0);
	}
}

