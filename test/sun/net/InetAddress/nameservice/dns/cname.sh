#!/bin/sh

#
# Copyright 2002 Sun Microsystems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara,
# CA 95054 USA or visit www.sun.com if you need additional information or
# have any questions.
#


# @test
# @bug 4763315
# @build CanonicalName Lookup 
# @run shell/timeout=120 cname.sh
# @summary Test DNS provider's handling of CNAME records


# The host that we try to resolve

HOST=webcache.sfbay.sun.com

# fail gracefully if DNS is not configured or there 
# isn't a CNAME record.

CLASSPATH=${TESTCLASSES}
export CLASSPATH
JAVA="${TESTJAVA}/bin/java"

sh -xc "$JAVA CanonicalName $HOST" 2>&1
if [ $? != 0 ]; then 
    echo "DNS not configured or host doesn't resolve to CNAME record"
    exit 0
fi

failures=0

go() {
    echo ''
    sh -xc "$JAVA $1 Lookup $2" 2>&1
    if [ $? != 0 ]; then failures=`expr $failures + 1`; fi
}

# Tests - with & without security manager

POLICY=java.policy
echo "grant {" > ${POLICY}
echo " permission java.net.SocketPermission \"${HOST}\", \"resolve\";" >> ${POLICY}
echo "};" >> ${POLICY}

np="-Dsun.net.spi.nameservice.provider.1=dns,sun"
sm="-Djava.security.manager -Djava.security.policy=${POLICY}"

go "$np" "$HOST"
go "$np $sm" "$HOST"


# 
# Results
#
echo ''
if [ $failures -gt 0 ];
  then echo "$failures test(s) failed";
  else echo "All test(s) passed"; fi
exit $failures
